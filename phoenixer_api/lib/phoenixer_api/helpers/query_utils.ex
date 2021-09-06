defmodule PhoenixerApi.Helpers.QueryUtil do
  import Ecto.Query, warn: false
  alias PhoenixerApi.Helpers.QueryUtil
  alias PhoenixerApi.Repo


  def query_where(args) do
    Enum.reduce(
      args.condition,
      dynamic(true),
      fn {key, value}, dynamic ->
        [field_string, operation] = String.split(key, ["-"])
        case operation do
          "eq" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) == ^value)
          "neq" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) != ^value)
          "gt" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) > ^value)
          "lt" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) < ^value)
          "gte" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) >= ^value)
          "lte" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) <= ^value)
          "ilike" -> dynamic([p], ^dynamic and ilike(field(p, ^String.to_atom(field_string)), ^"%#{value}%"))
          "like" -> dynamic([p], ^dynamic and like(field(p, ^String.to_atom(field_string)), ^"%#{value}%"))
          "in" -> dynamic([p], ^dynamic and field(p, ^String.to_atom(field_string)) in ^value)
        end
      end
    )
  end
  def query_where(args, tbl_alias) do
    Enum.reduce(
      args.condition,
      dynamic(true),
      fn {key, value}, dynamic ->
        [field_string, operation] = String.split(key, ["-"])
        case operation do
          "eq" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) == ^value)
          "neq" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) != ^value)
          "gt" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) > ^value)
          "lt" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) < ^value)
          "gte" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) >= ^value)
          "lte" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) <= ^value)
          "ilike" ->
            dynamic([{^tbl_alias, p}], ^dynamic and ilike(field(p, ^String.to_atom(field_string)), ^"%#{value}%"))
          "like" ->
            dynamic([{^tbl_alias, p}], ^dynamic and like(field(p, ^String.to_atom(field_string)), ^"%#{value}%"))
          "in" ->
            dynamic([{^tbl_alias, p}], ^dynamic and field(p, ^String.to_atom(field_string)) in ^value)
        end
      end
    )
  end

  def apply_pagination(query, args) do
    count = query
            |> where(^QueryUtil.query_where(args))
            |> Repo.aggregate(:count, :id)
    result = query
             |> where(^QueryUtil.query_where(args))
             |> Absinthe.Relay.Connection.from_query(&Repo.all/1, args)
    {:ok, edges} = result
    {:ok, Map.put(edges, :count, count)}
  end
end