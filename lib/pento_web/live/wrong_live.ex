defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    target = 1..10 |> Enum.random() |> Integer.to_string()
    {:ok, assign(socket, score: 0, message: "Make a guess:", target: target, found: false)}
  end

  def handle_event("guess", %{"number" => guess} = _data, socket)
      when socket.assigns.target == guess do
    message = "Your guess: #{guess}. Correct "
    score = socket.assigns.score + 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        found: true
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def handle_event("reset", _data, socket) do
    target = 1..10 |> Enum.random() |> Integer.to_string()

    {
      :noreply,
      assign(socket, score: 0, message: "Make a guess:", target: target, found: false)
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    </h2>
    <%= if !@found do %>
    <h2>
    <%= for n <- 1..10 do %>
    <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
    <% end %>
    </h2>
    <% else %>
    <a href="#" phx-click="reset" >Erneut spielen</a>
    <% end %>
    """
  end
end
