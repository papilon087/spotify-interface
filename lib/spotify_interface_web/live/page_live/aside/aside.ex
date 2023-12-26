defmodule SpotifyInterfaceWeb.PageLive.Aside do
  use SpotifyInterfaceWeb, :live_component

  def update(assigns, socket) do
    nav_menu_options = [
      %{icon: "hero-home", text: "Home"},
      %{icon: "hero-magnifying-glass", text: "Search"},
      %{icon: "hero-bookmark", text: "Your Library"}
    ]

    socket =
      socket
      |> assign(assigns)
      |> assign(:nav_menu_options, nav_menu_options)

    {:ok, socket}
  end
end
