defmodule PhoenixerApi.Repo.Migrations.CreateMediaPosts do
  use Ecto.Migration

  def change do
    create table(:media_posts) do
      add :file_url, :string
      add :file_type, :string
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:media_posts, [:post_id])
  end
end
