if Mix.env() in [:dev] do
  defmodule MonobankAPI.Generator.TestRenderer do
    use OpenAPIClient.Generator.TestRenderer

    @impl OpenAPIClient.Generator.TestRenderer
    def example(_state, {:integer, "timestamp-s"}, _path), do: 1_706_750_625

    def example(state, type, path),
      do: OpenAPIClient.Generator.TestRenderer.example(state, type, path)

    @impl OpenAPIClient.Generator.TestRenderer
    def render_callback_controller_header(state, operation) do
      state
      |> OpenAPIClient.Generator.TestRenderer.render_callback_controller_header(operation)
      |> Enum.flat_map(fn
        {:plug, _plug_metadata,
         [
           {:__aliases__, _alias_metadata, [:OpenAPIClient, :Plugs, :RequestTypedDecoder]}
         ]} = plug ->
          [plug, quote(do: plug(MonobankAPI.Plugs.Acquiring.WebhookSignatureChecker))]

        expression ->
          [expression]
      end)
    end

    @impl OpenAPIClient.Generator.TestRenderer
    def render_callback(state, operation) do
      {expression_new, _has_body_encoded} =
        state
        |> OpenAPIClient.Generator.TestRenderer.render_callback(operation)
        |> Macro.prewalk(false, fn
          {:assert, _assert_metadata,
           [
             {:=, _assign_metadata,
              [
                {:ok, {:body_encoded, _var_metadata, _var_args}}
                | _assign_rest_args
              ]}
           ]} = expression,
          _has_body_encoded ->
            {expression, true}

          {:|>, _pipe_metadata,
           [
             pipe_arg1,
             {{:., _call_metadata,
               [
                 {:__aliases__, _alias_metadata, [:Plug, :Conn]},
                 :put_req_header
               ]}, _put_req_header_metadata, _put_req_header_args} = pipe_arg2
           ]} = _expression,
          true ->
            {quote do
               unquote(pipe_arg1)
               |> Plug.Conn.put_req_header(
                 "x-sign",
                 MonobankAPI.Acquiring.WebhookHelpers.generate_x_sign(body_encoded)
               )
               |> unquote(pipe_arg2)
             end, false}

          expression, has_body_encoded ->
            {expression, has_body_encoded}
        end)

      expression_new
    end
  end
end
