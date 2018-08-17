# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :distributed_groceries, DistributedGroceriesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Jnf68ZT1K6fjUaKkY26W6x79Amw3c9qz6LWVOk7SCIAISgphPeun7EACrPn78Wqf",
  render_errors: [view: DistributedGroceriesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: DistributedGroceries.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
