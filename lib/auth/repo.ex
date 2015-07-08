defmodule Auth.Repo do
  use Ecto.Repo, otp_app: :auth
  use Scrivener, page_size: 50
end
