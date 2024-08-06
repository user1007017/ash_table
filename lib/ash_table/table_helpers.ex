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


    <%!-- left --%>

    <%= if @results.offset == 0 do %>
    <button id="dummy">
    <svg 

    fill="dark:text-white"
    class="bg-white dark:bg-slate-900 dark:text-slate-100 dark:fill-current text-white" 

    width="24px" height="24px" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
    <circle cx="16" cy="16" r="16"/>
    </svg>
    </button>
    <% else %>


    <button id="left" :if={@results.offset > 0 } phx-click="set_page" phx-value-offset={@results.offset - @results.limit} phx-target={@target} >

    <svg fill="dark:text-white"
    class="bg-white dark:bg-slate-900 dark:text-slate-100 dark:fill-current text-white" height="24px" width="24px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
    viewBox="0 0 330 330" xml:space="preserve">
    <path id="XMLID_6_" d="M165,0C74.019,0,0,74.019,0,165s74.019,165,165,165s165-74.019,165-165S255.981,0,165,0z M205.606,234.394
    c5.858,5.857,5.858,15.355,0,21.213C202.678,258.535,198.839,260,195,260s-7.678-1.464-10.606-4.394l-80-79.998
    c-2.813-2.813-4.394-6.628-4.394-10.606c0-3.978,1.58-7.794,4.394-10.607l80-80.002c5.857-5.858,15.355-5.858,21.213,0
    c5.858,5.857,5.858,15.355,0,21.213l-69.393,69.396L205.606,234.394z"/>
    </svg>

    </button>




    <% end %>



    <%!-- right --%>
    <button id="right" :if={@results.more?} phx-click="set_page" phx-value-offset={@results.offset + @results.limit} phx-target={@target} >

    <svg fill="dark:text-white"
    class="bg-white dark:bg-slate-900 dark:text-slate-100 dark:fill-current text-white" height="24px" width="24px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
    viewBox="0 0 330 330" xml:space="preserve">
    <path id="XMLID_2_" d="M165,0C74.019,0,0,74.019,0,165s74.019,165,165,165s165-74.019,165-165S255.981,0,165,0z M225.606,175.605
    l-80,80.002C142.678,258.535,138.839,260,135,260s-7.678-1.464-10.606-4.394c-5.858-5.857-5.858-15.355,0-21.213l69.393-69.396
    l-69.393-69.392c-5.858-5.857-5.858-15.355,0-21.213c5.857-5.858,15.355-5.858,21.213,0l80,79.998
    c2.814,2.813,4.394,6.628,4.394,10.606C230,168.976,228.42,172.792,225.606,175.605z"/>
    </svg>

    </button>


    <div :if={@results}>Viewing <%= @results.offset + 1 %> to <%= @results.offset + @results.limit %></div>


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
