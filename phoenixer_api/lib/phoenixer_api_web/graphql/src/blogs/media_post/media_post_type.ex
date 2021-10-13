defmodule PhoenixerApiWeb.Schema.Types.MediaPost do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias PhoenixerApi.Blogs

  object :media_post do
    field :id, :id
    field :file_type, :string
    field :file_url, :string
    field :post_id, :id
    field :success, :boolean
    field :message, :string

    #Relationship
    field :post, :post, resolve: dataloader(Blogs)
  end

end