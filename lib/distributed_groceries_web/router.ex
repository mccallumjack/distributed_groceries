defmodule DistributedGroceriesWeb.Router do
  use DistributedGroceriesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DistributedGroceriesWeb do
    pipe_through :api
    resources "/grocery_lists", GroceryListsController, only: [:create, :update, :show]
  end
end
