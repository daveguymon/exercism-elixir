defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real(a) do
    elem(a, 0)
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary(a) do
    elem(a, 1)
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
    {a, b} = format_input(a, b)

    real = (real(a) * real(b)) + (imaginary(a) * imaginary(b) * -1)
    imaginary =  (real(a) * imaginary(b)) + (imaginary(a) * real(b))

    {real, imaginary}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
    {a, b} = format_input(a, b)

    real_sum = real(a) + real(b)
    imaginary_sum = imaginary(a) + imaginary(b)

    {real_sum, imaginary_sum}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
    {a, b} = format_input(a, b)

    real_diff = real(a) - real(b)
    imaginary_diff = imaginary(a) - imaginary(b)

    {real_diff, imaginary_diff}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(e, f) do
    {a, b} = if is_tuple(e), do: e, else: {e, 0}
    {c, d} = if is_tuple(f), do: f, else: {f, 0}

    denom = c * c + d * d
    real = (a * c + b * d) / denom
    imaginary = (b * c - a * d) / denom

    {real, imaginary}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({a, b}) do
    (a**2 + b**2) ** 0.5
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({r, i}) do
    {r, i * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    exp_a = :math.exp(a)
    cos_b = :math.cos(b)
    sin_b = :math.sin(b)

    real_part = exp_a * cos_b
    imaginary_part = exp_a * sin_b

    {real_part, imaginary_part}
  end

  defp format_input(a, b) do
    a = if is_tuple(a), do: a, else: {a, 0}
    b = if is_tuple(b), do: b, else: {b, 0}

    {a, b}
  end
end
