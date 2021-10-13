defmodule PhoenixerApi.Blogs do
  @moduledoc """
  The Blogs context.
  """

  import Ecto.Query, warn: false
  alias PhoenixerApi.Repo
  alias PhoenixerApi.Helpers.QueryUtil

  alias PhoenixerApi.Blogs.Post

  def data() do
    Dataloader.Ecto.new(PhoenixerApi.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(args) do
    Post
    |> join(:inner, [p], _ in assoc(p, :user), as: :u)
    |> where(^QueryUtil.query_where(args))
    |> where(^QueryUtil.query_where(args.user_arg, :u))
    |> order_by(^QueryUtil.filter_order_by(args))
    |> QueryUtil.apply_pagination(args)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post(id), do: Repo.get(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:media_posts, attrs.media_posts)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias PhoenixerApi.Blogs.MediaPost

  @doc """
  Returns the list of media_posts.

  ## Examples

      iex> list_media_posts()
      [%MediaPost{}, ...]

  """
  def list_media_posts do
    Repo.all(MediaPost)
  end

  @doc """
  Gets a single media_post.

  Raises `Ecto.NoResultsError` if the Media post does not exist.

  ## Examples

      iex> get_media_post!(123)
      %MediaPost{}

      iex> get_media_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_media_post(id), do: Repo.get(MediaPost, id)

  @doc """
  Creates a media_post.

  ## Examples

      iex> create_media_post(%{field: value})
      {:ok, %MediaPost{}}

      iex> create_media_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_media_post(attrs \\ %{}) do
    %MediaPost{}
    |> MediaPost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a media_post.

  ## Examples

      iex> update_media_post(media_post, %{field: new_value})
      {:ok, %MediaPost{}}

      iex> update_media_post(media_post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_media_post(%MediaPost{} = media_post, attrs) do
    media_post
    |> MediaPost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a media_post.

  ## Examples

      iex> delete_media_post(media_post)
      {:ok, %MediaPost{}}

      iex> delete_media_post(media_post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_media_post(%MediaPost{} = media_post) do
    Repo.delete(media_post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media_post changes.

  ## Examples

      iex> change_media_post(media_post)
      %Ecto.Changeset{data: %MediaPost{}}

  """
  def change_media_post(%MediaPost{} = media_post, attrs \\ %{}) do
    MediaPost.changeset(media_post, attrs)
  end
end
