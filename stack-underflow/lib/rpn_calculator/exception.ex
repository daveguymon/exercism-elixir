defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception([]), do: %StackUnderflowError{}
    def exception(value), do: %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
  end

  def divide([]), do: raise StackUnderflowError.exception("when dividing")
  def divide([_]), do: raise StackUnderflowError.exception("when dividing")
  def divide([0, _]), do: raise RPNCalculator.Exception.DivisionByZeroError
  def divide([divisor, dividend]), do: div(dividend, divisor)
end
