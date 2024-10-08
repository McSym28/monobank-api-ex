if Mix.env() == :dev do
  defmodule Mix.Tasks.Generate do
    @moduledoc "Generates library's modules"
    use Mix.Task

    @acquiring_url "https://api.monobank.ua/docs/acquiring.html"
    @acquiring_fixture_path "test/fixtures/acquiring.json"

    @operation_changes [
      {"/api/merchant/details", "get", %{"tags" => ["merchants"], "operationId" => "getDetails"}},
      {"/api/merchant/pubkey", "get", %{"tags" => ["merchants"], "operationId" => "getPubkey"}},
      {"/api/merchant/statement", "get",
       %{
         "tags" => ["merchants"],
         "operationId" => "listStatements"
       }},
      {"/api/merchant/submerchant/list", "get",
       %{
         "tags" => ["merchants"],
         "operationId" => "listSubmerchants"
       }},
      {"/api/merchant/employee/list", "get",
       %{
         "tags" => ["merchants"],
         "operationId" => "listEmployees"
       }},
      {"/api/merchant/invoice/cancel", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "cancel"
       }},
      {"/api/merchant/invoice/create", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "create"
       }},
      {"/api/merchant/invoice/finalize", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "finalize"
       }},
      {"/api/merchant/invoice/fiscal-checks", "get",
       %{
         "tags" => ["invoices"],
         "operationId" => "listFiscalChecks"
       }},
      {"/api/merchant/invoice/payment-direct", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "createDirectPayment"
       }},
      {"/api/merchant/invoice/payment-info", "get",
       %{
         "tags" => ["invoices"],
         "operationId" => "getPaymentInfo"
       }},
      {"/api/merchant/invoice/remove", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "remove"
       }},
      {"/api/merchant/invoice/status", "get",
       %{
         "tags" => ["invoices"],
         "operationId" => "getStatus"
       }},
      {"/api/merchant/invoice/sync-payment", "post",
       %{
         "tags" => ["invoices"],
         "operationId" => "createSyncPayment"
       }},
      {"/api/merchant/qr/details", "get", %{"tags" => ["QR"], "operationId" => "getDetails"}},
      {"/api/merchant/qr/list", "get", %{"tags" => ["QR"], "operationId" => "list"}},
      {"/api/merchant/qr/reset-amount", "post",
       %{
         "tags" => ["QR"],
         "operationId" => "resetAmount"
       }},
      {"/api/merchant/wallet/card", "delete",
       %{
         "tags" => ["wallets"],
         "operationId" => "deleteCard"
       }},
      {"/api/merchant/wallet", "get", %{"tags" => ["wallets"], "operationId" => "get"}},
      {"/api/merchant/wallet/payment", "post",
       %{
         "tags" => ["wallets"],
         "operationId" => "createPayment"
       }}
    ]

    @forced_required_params [
      {"/api/merchant/wallet", "get", "walletId", "query"},
      {"/api/merchant/wallet/card", "delete", "cardToken", "query"},
      {"/api/merchant/statement", "get", "from", "query"},
      {"/api/merchant/qr/details", "get", "qrId", "query"},
      {"/api/merchant/invoice/status", "get", "invoiceId", "query"},
      {"/api/merchant/invoice/fiscal-checks", "get", "invoiceId", "query"},
      {"/api/merchant/invoice/payment-info", "get", "invoiceId", "query"}
    ]

    @requirements ["app.start"]
    @shortdoc "Generates library's modules"
    def run(_) do
      HTTPoison.start()

      with {:ok, body} <- http_request(@acquiring_url),
           {:ok, document} <- parse_document(body),
           {:ok, spec} <- find_spec(document) do
        spec
        |> traverse_spec([])
        |> Jason.encode!(pretty: true)
        |> then(&File.write!(@acquiring_fixture_path, &1))

        "lib/acquiring/**/*.ex"
        |> Path.wildcard()
        |> Enum.reject(fn
          "lib/acquiring/webhook.ex" -> true
          _file -> false
        end)
        |> Enum.each(&File.rm!/1)

        "test/acquiring/**/*.exs"
        |> Path.wildcard()
        |> Enum.reject(fn
          "test/acquiring/webhook_test.exs" -> true
          _file -> false
        end)
        |> Enum.each(&File.rm!/1)

        Mix.Task.run("api.gen", ["acquiring", @acquiring_fixture_path])
        Mix.Task.run("format")
      end
    end

    defp http_request(url) do
      case HTTPoison.get(url) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          {:ok, body}

        {:ok, %HTTPoison.Response{status_code: status_code} = response} ->
          IO.warn("Unexpected HTTP status code #{status_code}: `#{inspect(response)}`")
          :error

        {error, error} ->
          IO.warn("Received HTTP response error: `#{inspect(error)}`")
          :error
      end
    end

    defp parse_document(body) do
      case Floki.parse_document(body) do
        {:ok, document} ->
          {:ok, document}

        {:error, message} ->
          IO.warn("Error parsing HTML document: `#{inspect(message)}`")
          :error
      end
    end

    defp find_spec(document) do
      document
      |> Floki.find("script")
      |> Enum.reduce_while(:error, fn {_, _, script_body}, :error ->
        ~r/\{(?:[^}{]+|(?R))*+\}/
        |> Regex.scan(Enum.join(script_body))
        |> Enum.reduce_while(:error, fn [parens_object], :error ->
          parens_object
          |> Jason.decode()
          |> case do
            {:ok, %{"spec" => %{"data" => spec}}} -> {:halt, {:ok, spec}}
            _ -> {:cont, :error}
          end
        end)
        |> case do
          {:ok, _} = result -> {:halt, result}
          :error -> {:cont, :error}
        end
      end)
      |> case do
        {:ok, spec} ->
          {:ok, spec}

        :error ->
          IO.warn("Unable to find OAS spec")
          :error
      end
    end

    defguardp parameter_not_required?(map)
              when not is_map_key(map, "required") or :erlang.map_get("required", map) == false

    # Update `tags` and `operationId` to operations
    Enum.map(@operation_changes, fn {url, method, changes} ->
      defp traverse_spec(
             operation_spec,
             [unquote(method), unquote(url), "paths"] = path
           )
           when is_map(operation_spec) do
        operation_spec
        |> do_traverse_spec(path)
        |> Map.merge(%{unquote_splicing(Map.to_list(changes))})
      end
    end)

    # Fix incorrect examples
    defp traverse_spec(
           {"example", value},
           [
             "example",
             "cvv",
             "properties",
             "cardData",
             "properties",
             "PaymentDirectRequest",
             "schemas",
             "components"
           ] = _path
         )
         when not is_binary(value) do
      {"example", to_string(value)}
    end

    defp traverse_spec(
           {"example", value},
           [
             "example",
             "sst",
             "properties",
             "cardData",
             "properties",
             "InvoiceSyncPaymentRequest",
             "schemas",
             "components"
           ] = _path
         )
         when not is_number(value) do
      {float_value, ""} = Float.parse(value)
      {"example", float_value}
    end

    # Force required params
    Enum.map(@forced_required_params, fn {url, method, name, location} ->
      defp traverse_spec(
             %{"name" => unquote(name), "in" => unquote(location)} = value,
             [[_index], "parameters", unquote(method), unquote(url), "paths"] = path
           )
           when parameter_not_required?(value) do
        value
        |> Map.put("required", true)
        |> traverse_spec(path)
      end
    end)

    # Change `from`/`to` parameters' format to treat them as `DateTime`'s
    defp traverse_spec(
           %{
             "name" => timestamp_property,
             "in" => "query",
             "schema" => %{"type" => "integer"} = schema
           } = value,
           [[_index], "parameters", "get", "/api/merchant/statement", "paths"] = path
         )
         when timestamp_property in ~w(from to) and
                (not is_map_key(schema, "format") or
                   :erlang.map_get("format", schema) != "timestamp-s") do
      value
      |> put_in(["schema", "format"], "timestamp-s")
      |> traverse_spec(path)
    end

    # Fix invalid required attributes (not strictly necessary)
    defp traverse_spec(
           %{"type" => schema_type, "required" => required} = value,
           ["schema" | _] = path
         )
         when schema_type != "object" and is_boolean(required) do
      value
      |> Map.delete("required")
      |> traverse_spec(path)
    end

    defp traverse_spec(
           %{"type" => schema_type, "required" => required} = value,
           [_name, "properties" | _] = path
         )
         when schema_type != "object" and is_boolean(required) do
      value
      |> Map.delete("required")
      |> traverse_spec(path)
    end

    defp traverse_spec(
           %{"type" => schema_type, "required" => required} = value,
           [_name, "schemas", "components"] = path
         )
         when schema_type != "object" and is_boolean(required) do
      value
      |> Map.delete("required")
      |> traverse_spec(path)
    end

    # Remove query parameters from path URLs
    defp traverse_spec({url, value}, [url | ["paths"] = rest_path]) do
      url_new = url |> URI.parse() |> struct!(query: nil) |> URI.to_string()
      do_traverse_spec({url_new, value}, [url_new | rest_path])
    end

    defp traverse_spec(key_andor_value, path), do: do_traverse_spec(key_andor_value, path)

    defp do_traverse_spec({key, map}, path) when is_map(map) do
      {key, traverse_spec(map, path)}
    end

    defp do_traverse_spec({key, list}, path) when is_list(list) do
      {key, traverse_spec(list, path)}
    end

    defp do_traverse_spec(map, path) when is_map(map) do
      Map.new(map, fn {key, value} -> traverse_spec({key, value}, [key | path]) end)
    end

    defp do_traverse_spec(list, path) when is_list(list) do
      list
      |> Enum.with_index()
      |> Enum.map(fn {value, index} -> traverse_spec(value, [[index] | path]) end)
    end

    defp do_traverse_spec(key_andor_value, _path), do: key_andor_value
  end
end
