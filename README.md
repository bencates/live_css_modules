# CSSModules

An implementation of CSS Modules for Phoenix LiveView apps.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_css_modules` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_css_modules, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/live_css_modules](https://hexdocs.pm/live_css_modules).

### TODO: set up compiler, see standalone SASS

## Usage

```css
/* thermostat_live.module.css */
.temperature {
  font-weight: bold;
}
```

```elixir
# thermostat_live.ex
defmodule MyAppWeb.ThermostatLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  import CSSModules, only: [assign_styles: 0]

  def render(assigns) do
    ~H"""
    Current temperature: <span class={@styles.temperature}><%= @temperature %></span>
    """
  end

  def mount(_params, %{"current_user_id" => user_id}, socket) do
    temperature = Thermostat.get_user_reading(user_id)

    {:ok,
     socket
     |> assign(:temperature, temperature)}
     |> assign_styles(:styles)
  end
end
```
