defmodule AshTable.TableHelpers do
  @moduledoc false
  use Phoenix.Component

  def column_header(assigns) do
    ~H"""
    <th
      scope="col"
      role="columnheader"
      aria-sort={sort_class(@column, @sort)}
      width={if @column[:min], do: "1px"}
      class={if @column[:header_class], do: @column[:header_class]}
    >
      <%= render_slot(@inner_block) %>
    </th>
    """
  end

  def sort_button(assigns) do
    ~H"""
    <button
      phx-click="sort"
      phx-target={@target}
      phx-value-column={@column.sort_key}
      phx-value-direction={sort_direction(@column, @sort)}
      class={sort_class(@column, @sort)}
    >
      <%= @column.label %> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-down-up ml-2"><path d="m3 16 4 4 4-4"></path><path d="M7 20V4"></path><path d="m21 8-4-4-4 4"></path><path d="M17 4v16"></path></svg>
    </button>
    """
  end

  def paginator(assigns) do
    ~H"""
    <div class="paginator">
    <div :if={@results}>Viewing <%= @results.offset + 1 %> to <%= @results.offset + @results.limit %></div>

    <button :if={@results.offset > 0} phx-click="set_page" phx-value-offset={@results.offset - @results.limit} phx-target={@target}>Previous</button>

    <%= if {@results.offset > 0} do %>
    &nbsp;/&nbsp;
    <% end %>

    <button :if={@results.more?} phx-click="set_page" phx-value-offset={@results.offset + @results.limit} phx-target={@target}>Next</button>
    </div>
    """
  end

  defp sort_direction(column, sort) do
    with %{sort_key: column_key} when is_binary(column_key) <- column,
         {^column_key, direction} <- sort do
      toggle_direction(direction)
    else
      _ -> :asc
    end
  end

  defp toggle_direction(:asc), do: :desc
  defp toggle_direction(:desc), do: :asc

  defp sort_class(column, sort) do
    with %{sort_key: column_key} when is_binary(column_key) <- column,
         {^column_key, direction} <- sort do
      Atom.to_string(direction)
    else
      _ -> "none"
    end
  end
end
