defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a, b}, {c, d}) do
    num = a * d + b * c

    denom = cond do
      num == 0 -> 1
      b == d -> b
      true -> b * d
    end

    {num, denom}
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a, b}, {c, d}) do
    num = a * d - b * c
    
    denom = cond do
      num == 0 -> 1
      b == d -> b
      true -> b * d
    end

    {num, denom}
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a, b}, {c, d}) do
    num = a * c
    denom = b * d

    case num do
      0 -> {0, 1}
      _ -> do_reduce(num, denom)
    end
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a, b}, {c, d}) do
    num = a * d
    denom = b * c 

    case num do
      0 -> {0, 1}
      _ -> do_reduce(num, denom)
    end
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a,b}) do
    num = trunc(:math.sqrt(a**2))
    denom = trunc(:math.sqrt(b**2))

    case num do
      0 -> {0, 1}
      _ -> do_reduce(num, denom)
    end
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) do
    {num, denom} = if n < 0 do
      n = trunc(:math.sqrt(n**2))
      {Integer.pow(b, n), Integer.pow(a, n)}
    else
      {Integer.pow(a, n), Integer.pow(b, n)}
    end

    case num do
      0 -> {0, 1}
      _ -> do_reduce(num, denom)
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    :math.pow(x, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) do
    gcd = Integer.gcd(a, b)

    num = div(a, gcd)
    denom = div(b, gcd)
    
    case num do
      0 -> {0, 1}
      _ -> do_reduce(num, denom)
    end
  end


  defp do_reduce(num, denom) do
    mod = rem(denom, num)

    if mod == 0 do
      {simple_num, simple_denom} = simplify(num, denom)
      normalize_sign(simple_num, simple_denom)
    else
      normalize_sign(num, denom)
    end
  end

  defp simplify(num, denom) do
    simple_num = div(num, num)
    simple_denom = div(denom,num)
    {simple_num, simple_denom}
  end

  defp normalize_sign(num, denom) when denom < 0 do
    {num * -1, denom * -1}
  end

  defp normalize_sign(num, denom) do
    {num, denom}
  end
end
