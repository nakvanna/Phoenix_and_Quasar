defmodule PhoenixerApiWeb.PageController do
  use PhoenixerApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def file_upload(conn, params) do
    file = params["file"]
    File.cp(file.path, "assets/static/uploads/#{file.filename}")
    json(conn, %{success: true, url: "uploads/#{file.filename}"})
  end
end
