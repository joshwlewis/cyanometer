defmodule :"Elixir.Cyanometer.Repo.Migrations.Scope takenAt to location" do
  use Ecto.Migration

  def change do
    IO.puts("Running Scope takenAt")
    drop unique_index(:images, [:taken_at])
    create unique_index(:images, [:taken_at, :location_id])
    IO.puts("Ran Scope takenAt")
  end
end
