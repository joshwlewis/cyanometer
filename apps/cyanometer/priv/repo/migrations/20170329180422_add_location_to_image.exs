defmodule Cyanometer.Repo.Migrations.AddLocationToImage do
  use Ecto.Migration

  def change do
    IO.puts("Running AddLocationToImage")
    alter table(:images) do
      add :location_id, references(:locations, on_delete: :delete_all)
    end

    create index(:images, [:location_id])
    IO.puts("Ran AddLocationToImage")
  end
end
