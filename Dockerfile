# Use the official Elixir image as a base
FROM elixir:latest

RUN apt-get update
RUN apt-get install cmake -y

# Create and set the working directory
WORKDIR /app

# Copy your application code to the container
COPY . .

# Install Hex + Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Fetch and compile your Elixir dependencies
RUN mix deps.get && \
    mix deps.compile

# Compile your Elixir application
RUN mix compile

# The command to run when the container starts
CMD ["mix", "run", "scripts/run.exs"]