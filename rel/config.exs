use Mix.Releases.Config

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"simple_cookie"
end

release :distributed_groceries do
  set version: current_version(:distributed_groceries)
  set applications: [
    :runtime_tools
  ]
end

