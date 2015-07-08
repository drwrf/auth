defmodule Mix.Tasks.Serve do
  alias Mix.Tasks.Phoenix.Server
  use Mix.Task

  def run(args) do
    Mix.shell.info "Starting Phoenix backend on port 4000"
    Server.run(args)

    Mix.shell.info "Starting Ember frontend on port 4200"
    Mix.shell.cmd "cd frontend && npm start"
  end
end
