defmodule PhoenixerApi.BlogsTest do
  use PhoenixerApi.DataCase

  alias PhoenixerApi.Blogs

  describe "posts" do
    alias PhoenixerApi.Blogs.Post

    @valid_attrs %{content: "some content", status: "some status", title: "some title"}
    @update_attrs %{content: "some updated content", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{content: nil, status: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blogs.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blogs.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blogs.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.status == "some status"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blogs.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.status == "some updated status"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_post(post, @invalid_attrs)
      assert post == Blogs.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blogs.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blogs.change_post(post)
    end
  end

  describe "media_posts" do
    alias PhoenixerApi.Blogs.MediaPost

    @valid_attrs %{file_type: "some file_type", file_url: "some file_url"}
    @update_attrs %{file_type: "some updated file_type", file_url: "some updated file_url"}
    @invalid_attrs %{file_type: nil, file_url: nil}

    def media_post_fixture(attrs \\ %{}) do
      {:ok, media_post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_media_post()

      media_post
    end

    test "list_media_posts/0 returns all media_posts" do
      media_post = media_post_fixture()
      assert Blogs.list_media_posts() == [media_post]
    end

    test "get_media_post!/1 returns the media_post with given id" do
      media_post = media_post_fixture()
      assert Blogs.get_media_post!(media_post.id) == media_post
    end

    test "create_media_post/1 with valid data creates a media_post" do
      assert {:ok, %MediaPost{} = media_post} = Blogs.create_media_post(@valid_attrs)
      assert media_post.file_type == "some file_type"
      assert media_post.file_url == "some file_url"
    end

    test "create_media_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_media_post(@invalid_attrs)
    end

    test "update_media_post/2 with valid data updates the media_post" do
      media_post = media_post_fixture()
      assert {:ok, %MediaPost{} = media_post} = Blogs.update_media_post(media_post, @update_attrs)
      assert media_post.file_type == "some updated file_type"
      assert media_post.file_url == "some updated file_url"
    end

    test "update_media_post/2 with invalid data returns error changeset" do
      media_post = media_post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_media_post(media_post, @invalid_attrs)
      assert media_post == Blogs.get_media_post!(media_post.id)
    end

    test "delete_media_post/1 deletes the media_post" do
      media_post = media_post_fixture()
      assert {:ok, %MediaPost{}} = Blogs.delete_media_post(media_post)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_media_post!(media_post.id) end
    end

    test "change_media_post/1 returns a media_post changeset" do
      media_post = media_post_fixture()
      assert %Ecto.Changeset{} = Blogs.change_media_post(media_post)
    end
  end
end
