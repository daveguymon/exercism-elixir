defmodule RPNCalculator do
  def calculate!(stack, operation) do
    try do
      operation.(stack)
    rescue
      _exception -> raise "test error"
    end
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _exception -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      exception -> {:error, exception.message}
    end
  end
end
