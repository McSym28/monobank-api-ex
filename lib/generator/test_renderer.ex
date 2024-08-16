if Mix.env() in [:dev] do
  defmodule MonobankAPI.Generator.TestRenderer do
    use OpenAPIClient.Generator.TestRenderer

    @impl OpenAPIClient.Generator.TestRenderer
    def type_example(_state, {:integer, "timestamp-s"}, _path), do: 1_706_750_625

    def type_example(state, type, path),
      do: OpenAPIClient.Generator.TestRenderer.type_example(state, type, path)
  end
end
