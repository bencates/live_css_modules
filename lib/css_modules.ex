defmodule CSSModules do
  @moduledoc """
  Documentation for `CSSModules`.
  """

  @css_class_regex ~r/\.-?[_a-zA-Z]+[_a-zA-Z0-9-]*/

  @doc """
  Hello world.

  ## Examples

      iex> CSSModules.hello()
      :world

  """
  def css_module(root_path, name) do
    path = Path.join(root_path, "#{name}.module.css")
    hash = :crypto.hash(:md5, path) |> Base.url_encode64(padding: false)

    contents =
      case File.read(path) do
        {:ok, contents} -> contents
        {:error, _reason} -> ""
      end

    classes =
      @css_class_regex
      |> Regex.scan(contents)
      |> Enum.uniq()
      |> List.flatten()
      |> Enum.map(&(&1 |> String.trim_leading(".") |> String.to_atom()))

    contents = Regex.replace(@css_class_regex, contents, "\\0__#{hash}", global: true)

    Enum.reduce(
      classes,
      %{__meta__: %{path: path, hash: hash, contents: contents}},
      &Map.put(&2, &1, "#{&1}__#{hash}")
    )
  end
end
