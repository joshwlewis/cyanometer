defmodule Cyanometer.Repo.Migrations.NotNullLocationFields do
  use Ecto.Migration

  def change do
    IO.puts("Running NotNullLocationFields")
    alter table(:locations) do
      modify :country, :string, null: false
      modify :city, :string, null: false
      modify :place, :string, null: false
    end
    IO.puts("Ran NotNullLocationFields")
  end
end
