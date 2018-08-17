FROM bitwalker/alpine-elixir-phoenix as builder

ENV MIX_ENV=prod
ENV REPLACE_OS_VARS=true

WORKDIR /app

COPY mix.* ./

RUN mix deps.get && mix deps.compile

COPY . .

RUN mix release --env=prod

# Runtime
FROM alpine:3.7

# We need bash and openssl for Phoenix
RUN apk upgrade --no-cache add git wget && \
    apk add --no-cache bash openssl

ENV MIX_ENV=prod \
    SHELL=/bin/bash \
    REPLACE_OS_VARS=true

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/distributed_groceries/releases/0.0.1/distributed_groceries.tar.gz .

RUN tar -xzf distributed_groceries.tar.gz && rm distributed_groceries.tar.gz

CMD ["./bin/distributed_groceries", "foreground"]
