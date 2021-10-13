defmodule PhoenixerApi.Blogs.MediaPost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "media_posts" do
    field :file_type, :string
    field :file_url, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(media_post, attrs) do
    media_post
    |> cast(attrs, [:file_url, :file_type])
    |> validate_required([:file_url, :file_type])
  end
end
