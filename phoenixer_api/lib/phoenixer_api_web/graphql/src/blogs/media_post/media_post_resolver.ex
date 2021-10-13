defmodule PhoenixerApiWeb.Schema.Resolvers.MediaPost do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  alias PhoenixerApi.Blogs

  # connection for relay
  connection node_type: :media_post do
    field :count, :integer
    # must include edge
    edge do
    end
  end

  object :media_post_queries do
    connection field :media_posts, node_type: :media_post do
      arg :condition, non_null(:json)
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn _args, _
        ->
          Blogs.list_media_posts
        end
      )
    end

    field :find_media_post, :media_post do
      arg :id, :id
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          case Blogs.get_media_post(args.id) do
            nil -> {:error, "MediaPost ID #{args.id} not found!"}
            media_post -> {:ok, media_post}
          end
        end
      )
    end
  end

  object :media_post_mutations do
    field :create_media_post, :media_post do
      arg :data, non_null(:create_media_post_input_type)
      #      middleware PhoenixerApiWeb.Graphql.Middleware, "user"
      resolve(
        fn args, _ ->
          #                    Blogs.create_media_post(args.data)
          IO.inspect args.data
          {:ok, %{success: 'Testing'}}
        end
      )
    end

    field :update_media_post, :media_post do
      arg :id, :id
      arg :data, :update_media_post_input_type
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          media_post = Blogs.get_media_post(args.id)
          if media_post == nil do
            {:error, %{success: false, message: "No result found to update!"}}
          else
            Blogs.update_media_post(media_post, args.data)
          end
        end
      )
    end

    field :delete_media_post, :media_post do
      arg :id, :id
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          media_post = Blogs.get_media_post(args.id)
          if media_post == nil do
            {:error, %{success: false, message: "No result found to delete!"}}
          else
            Blogs.delete_media_post(media_post)
          end
        end
      )
    end
  end

end