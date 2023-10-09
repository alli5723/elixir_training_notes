# Use the official Elixir image as the base image
FROM elixir:1.15-alpine AS build

# Set the working directory for the application
WORKDIR /app

# Copy the mix.exs and mix.lock files to the container
COPY mix.exs mix.lock ./

# Install mix dependencies
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod

# Copy the rest of the application code to the container
COPY . .

ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=f9yth2Fc7Ii1Y8qh8zqlFBjb9fLxLJi5ZCCLPiOSydP

# Expose the port that the application will listen on
EXPOSE 4000

# CMD ["mix", "phx.server"]