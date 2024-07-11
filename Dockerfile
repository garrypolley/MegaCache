# Use the official Elixir image as a base
FROM elixir:latest

RUN apt-get update
RUN apt-get install cmake -y

# Create and set the working directory
WORKDIR /app

# Copy your application code to the container
ENV MIX_ENV="prod"

RUN mix local.hex --force && mix local.rebar --force

COPY . .

RUN mix deps.get --only prod
RUN mix release

EXPOSE 5858

ENTRYPOINT ["/app/_build/prod/rel/mega_cache/bin/mega_cache"]
CMD ["start"]
