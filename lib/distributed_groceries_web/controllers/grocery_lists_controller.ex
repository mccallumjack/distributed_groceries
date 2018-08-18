defmodule DistributedGroceriesWeb.GroceryListsController do
  use DistributedGroceriesWeb, :controller

  def create(conn, %{"name" => name}) do
    case lookup_pid(name) do
      :undefined  ->
        {:ok, pid} = Agent.start(fn -> %{} end)
        register_pid(pid, name)
        json(conn, "Success!: #{name} was created")
      _ ->
        json(conn, "Already Registered")
    end
  end

  def update(conn, %{"id" => name, "item" => item, "quantity" => num}) do
    case lookup_pid(name) do
      :undefined ->
        json(conn, "#{name} not found")
      pid ->
        Agent.update(pid, fn state -> Map.put(state, item, num) end)
        json(conn, "Success!")
    end
  end

  def show(conn, %{"id" => name}) do
    case lookup_pid(name) do
      :undefined ->
        json(conn, "#{name} not found")
      pid ->
        json(conn, Agent.get(pid, fn state -> state end))
    end
  end

  defp lookup_pid(name) do
    :global.whereis_name({:grocery_list, name})
  end

  defp register_pid(pid, name) do
    :global.register_name({:grocery_list, name}, pid)
  end
end
