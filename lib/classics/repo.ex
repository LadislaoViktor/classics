defmodule Classics.Repo do
  use Ecto.Repo,
    otp_app: :classics,
    adapter: Ecto.Adapters.Postgres
end
