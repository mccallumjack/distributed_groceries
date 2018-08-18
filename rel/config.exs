use Mix.Releases.Config

environment :prod do
  set include_erts: true
  set include_src: false
  set vm_args: "rel/vm.args"
  set pre_configure_hooks: "rel/hooks/pre_configure.d"
end

release :distributed_groceries do
  set version: current_version(:distributed_groceries)
  set applications: [
    :runtime_tools
  ]
end
