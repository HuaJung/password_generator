defmodule PasswordGenerator do
  @moduledoc """
  Generates random password depending on parameters, Module main function is `generate(options)`
  That function takes the options map.
  Options example:
      options = %{
        "length" => "5",
        "number" => "false",
        "uppercase" => " false"
        "symbols" "false"
      }
  The options ar eonly 4, `lebgth`, `number`, `uppercase`, `symbols`.
  """
  @allowed_options [:length, :numbers, :uppercase, :symbols]

  @doc """
  Generates password for given options:application:

  ## Examples
      options = %{
        "length" => "10",
        "number" => "false",
        "uppercase" => "false",
        "symbols" => "false"
      }
      iex> PasswordGenerator.generate(options)
      "abcdf"

      options = %{
        "length" => "5",
        "number" => "true",
        "uppercase" => " false",
        "symbols" => "false"
      }
      iex> PasswordGenerator.generate(options)
      "abcd3"
  """

  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    validate_length(length, options)
  end

  defp validate_length(false, _options), do: {:error, "Please provide length"}
  defp validate_length(true, options) do
    numbers = Enum.map(0..9, & Integer.to_string(&1))
    length = options["length"]
    length = String.contains?(length, numbers)
    validate_length_is_integer(length, options)

    # validate_length_integer = options["length"] |> String.to_integer |> is_integer()
  end

  defp validate_length_is_integer(false, _options), do: {:error, "Only integers allowed for length."}
  defp validate_length_is_integer(true, options) do
    length = options["length"] |> String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)
    value = options_values |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)

    validate_options_values_are_boolean(value, length, options_without_length)
  end

  defp validate_options_values_are_boolean(false, _length, _options) do
    {:error, "Only booleans allowed for options values"}
  end
  defp validate_options_values_are_boolean(true, length, options) do
    options = included_options(options)
    invalid_options? = options |> Enum.any?(&(&1 not in @allowed_options))
    validate_options(invalid_options?, length, options)
  end

  defp validate_options(true, _length, _options) do
    {:error, "Only allowed numbers, uppercase, symbols."}
  end
  defp validate_options(false, length, options) do
    generate_strings(length, options)
  end

  defp generate_strings(length, options) do
    options = [:lowercase_letter | options]
    included = include(options)
    length = length - length(included)
    random_strings = generate_random_strings(length, options)
    strings = included ++ random_strings
    get_result(strings)
  end

  defp get_result(strings) do
    string =
      strings
      |> Enum.shuffle()
      |> to_string()

    {:ok, string}
  end

  defp include(options) do
    options |> Enum.map(&get(&1))
  end


  @symbols "!#$%&()*+,-./:;<=>?@[]^_{|}~"
  def get(atom) do
    cond do
      atom == :lowercase_letter ->
        <<Enum.random(?a..?z)>>
      atom == :uppercase ->
        <<Enum.random(?A..?Z)>>
      atom == :numbers ->
        Enum.random(0..9) |> Integer.to_string()
      atom == :symbols ->
        symbols = @symbols |> String.split("", trim: true)
        Enum.random(symbols)
    end
  end

  defp included_options(options) do
    Enum.filter(options, fn {_key, value} ->
      value |> String.trim() |> String.to_existing_atom()
    end)
    |> Enum.map(fn {key, _value} -> String.to_atom(key) end)
  end

  defp generate_random_strings(length, options) do
    Enum.map(1..length, fn _ ->
      Enum.random(options) |> get()
    end)
  end

end
