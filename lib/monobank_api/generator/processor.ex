if Mix.env() in [:dev] do
  defmodule MonobankAPI.Generator.Processor do
    use OpenAPIClient.Generator.Processor

    alias OpenAPI.Spec.Path.Operation, as: OperationSpec
    alias OpenAPI.Spec.Path.Parameter, as: ParamSpec

    @impl OpenAPI.Processor
    def ignore_operation?(
          %OpenAPI.Processor.State{} = state,
          %OperationSpec{
            "$oag_path": "/__callbacks__/" <> _rest_request_path,
            parameters: parameters
          } = operation_spec
        ) do
      parameters_new =
        Enum.reject(parameters, fn %ParamSpec{name: name, in: location} ->
          String.downcase(name) == "x-sign" and location == "header"
        end)

      OpenAPIClient.Generator.Processor.ignore_operation?(state, %OperationSpec{
        operation_spec
        | parameters: parameters_new
      })
    end

    def ignore_operation?(state, operation_spec),
      do: OpenAPIClient.Generator.Processor.ignore_operation?(state, operation_spec)
  end
end
