defmodule Mix.Tasks.Install do
  use Mix.Task

  def run(_) do
    Mix.shell.info "Installing Elixir dependencies..."
    Mix.shell.cmd "mix deps.get"

    Mix.shell.info "Installing Node dependencies..."
    Mix.shell.cmd "cd frontend && npm install"
  end
end
