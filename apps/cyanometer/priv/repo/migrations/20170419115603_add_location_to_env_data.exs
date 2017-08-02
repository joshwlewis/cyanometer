defmodule Cyanometer.Repo.Migrations.AddLocationToEnvData do
  use Ecto.Migration

  def change do
    IO.puts("Running Add Location to Env Data")
    alter table(:environmental_datas) do
      add :location_id, references(:locations, on_delete: :delete_all)
    end

    create index(:environmental_datas, [:location_id])

    drop unique_index(:environmental_datas, [:taken_at])
    create unique_index(:environmental_datas, [:taken_at, :location_id])
    IO.puts("Ran Add Location to Env Data")
  end
end
