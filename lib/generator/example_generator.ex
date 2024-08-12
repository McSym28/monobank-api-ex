if Mix.env() in [:dev, :test] do
  defmodule MonobankAPI.Generator.ExampleGenerator do
    alias OpenAPIClient.Generator.ExampleGenerator

    @behaviour ExampleGenerator

    @doc """
    Generate example value for a specific type

    ## Examples

        iex> timestamp = #{__MODULE__}.generate({:integer, "timestamp-s"}, [], #{__MODULE__})
        iex> is_integer(timestamp)
        true

    """
    @impl ExampleGenerator
    def generate({:integer, "timestamp-ms"}, _path, _caller_module), do: 1_706_750_625

    def generate(type, path, caller_module),
      do: ExampleGenerator.generate(type, path, caller_module)
  end
end
