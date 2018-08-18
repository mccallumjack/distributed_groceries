defmodule DistributedGroceries.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    connect_to_cluster()

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(DistributedGroceriesWeb.Endpoint, []),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedGroceries.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DistributedGroceriesWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def connect_to_cluster do
    # Docker internal DNS lookup
    {string, _} = System.cmd("nslookup", ["tasks.distributed_groceries_app"])

    # Fetch IPs from String
    ips =
      Regex.scan(~r/10\.[0-9]\.[0-9]\.\d{1,}/, string)
      |> List.flatten
      |> Enum.reject(
        fn x -> x == System.get_env("CONTAINER_IP")
      end)

    # Connect to Nodes
    Enum.map(ips, fn ip ->
      Node.connect(:"distributed_groceries@#{ip}")
    end)
  end

end
