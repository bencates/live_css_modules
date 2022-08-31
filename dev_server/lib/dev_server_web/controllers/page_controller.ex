defmodule DevServerWeb.PageController do
  use DevServerWeb, :controller

  def index(conn, _params) do
    root_path = view_module(conn).__templates__() |> elem(0)

    conn
    |> assign(:styles, CSSModules.css_module(root_path, :index))
    |> render("index.html")
  end
end
