defmodule DevServerWeb.PageController do
  use DevServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
