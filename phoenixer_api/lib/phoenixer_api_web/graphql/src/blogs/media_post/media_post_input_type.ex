defmodule PhoenixerApiWeb.Schema.InputTypes.MediaPost do
  use Absinthe.Schema.Notation

  input_object :create_media_post_input_type do
    field :post_id, :id
    field :file_type, non_null(:string)
    field :file_url, non_null(:string)
  end

  input_object :update_media_post_input_type do
    field :file_type, :string
    field :file_url, :string
    field :post_id, :id
  end
end