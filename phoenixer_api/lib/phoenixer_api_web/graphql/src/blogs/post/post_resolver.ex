defmodule PhoenixerApiWeb.Schema.Resolvers.Post do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  alias PhoenixerApi.Blogs

  # connection for relay
  connection node_type: :post do
    field :count, :integer
    # must include edge
    edge do
    end
  end

  object :post_queries do
    connection field :posts, node_type: :post do
      arg :condition, non_null(:json)
      arg :user_arg, non_null(:arg_condition)
      arg(:order_by, :string)
      #      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _
        ->
          Blogs.list_posts(args)
        end
      )
    end

    field :find_post, :post do
      arg :id, :id
      #      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          case Blogs.get_post(args.id) do
            nil -> {:error, "Post ID #{args.id} not found!"}
            post -> {:ok, post}
          end
        end
      )
    end
  end

  object :post_mutations do
    field :create_post, :post do
      arg :data, non_null(:create_post_input_type)
      #      middleware PhoenixerApiWeb.Graphql.Middleware, "user"
      resolve(
        fn args, _ ->
          Blogs.create_post(args.data)
          #          {:ok, %{success: true, message: "testing"}}
        end
      )
    end

    field :update_post, :post do
      arg :id, :id
      arg :data, :update_post_input_type
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          post = Blogs.get_post(args.id)
          if post == nil do
            {:error, %{success: false, message: "No result found to update!"}}
          else
            Blogs.update_post(post, args.data)
          end
        end
      )
    end

    field :delete_post, :post do
      arg :id, :id
      middleware PhoenixerApiWeb.Graphql.Middleware, ["user"]
      resolve(
        fn args, _ ->
          post = Blogs.get_post(args.id)
          if post == nil do
            {:error, %{success: false, message: "No result found to delete!"}}
          else
            Blogs.delete_post(post)
          end
        end
      )
    end
  end

end