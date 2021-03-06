defmodule PhoenixerApiWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias PhoenixerApi.{Accounts, Blogs}

  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Blogs, Blogs.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  ##Custom Scalar type
  import_types(
    PhoenixerApiWeb.Schema.Types.Custom.{JSON}
  )

  ##Query types
  import_types(
    PhoenixerApiWeb.Schema.Types.{
      User,
      Session,
      Post,
      MediaPost
      }
  )

  ##Mutation types
  import_types(
    PhoenixerApiWeb.Schema.InputTypes.{
      User,
      Session,
      Post,
      MediaPost
      }
  )

  ##Resolver type
  import_types(
    PhoenixerApiWeb.Schema.Resolvers.{
      User,
      Session,
      Post,
      MediaPost
      }
  )

  # root query
  input_object :arg_condition do
    field :condition, :json
  end

  query do
    import_fields :user_queries
    import_fields :post_queries
    import_fields :media_post_queries
  end

  mutation do
    import_fields :session_mutations
    import_fields :user_mutations
    import_fields :post_mutations
    import_fields :media_post_mutations
  end

end