defmodule DistributedGroceriesWeb.Router do
  use DistributedGroceriesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DistributedGroceriesWeb do
    pipe_through :api
  end
end
