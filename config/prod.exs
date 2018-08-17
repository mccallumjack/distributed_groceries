use Mix.Config
config :distributed_groceries, DistributedGroceriesWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "localhost", port: {:system, "PORT"}],
  secret_key_base: "my_super_secret_key",
  server: true

config :logger, level: :info
