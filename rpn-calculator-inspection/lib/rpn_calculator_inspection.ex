defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    response = receive do
      {:EXIT, ^pid, :normal} -> %{input => :ok}
      {:EXIT, ^pid, _} -> %{input => :error}
    after 
      100 -> %{input => :timeout}
    end

    Map.merge(results, response)
  end

  def reliability_check(_calculator, []), do: %{}
  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit, true)

    output = inputs
    |> Enum.map(&start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, flag)
    output
  end

  def correctness_check(_calculator, []), do: []
  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end
end
