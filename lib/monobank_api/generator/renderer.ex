if Mix.env() in [:dev] do
  defmodule MonobankAPI.Generator.Renderer do
    use OpenAPIClient.Generator.Renderer

    @impl OpenAPI.Renderer
    def render_type(_state, {:integer, "timestamp-s"}), do: quote(do: DateTime.t())
    def render_type(state, type), do: OpenAPIClient.Generator.Renderer.render_type(state, type)
  end
end
