defmodule PhoenixerApiWeb.Schema.InputTypes.Post do
  use Absinthe.Schema.Notation

  input_object :create_post_input_type do
    field :status, non_null(:string)
    field :title, non_null(:string)
    field :content, non_null(:string)
    field :user_id, non_null(:id)
    field :media_posts, list_of(:create_media_post_input_type)
  end

  input_object :update_post_input_type do
    field :status, :string
    field :title, :string
    field :content, :string
    field :user_id, :id
  end
end