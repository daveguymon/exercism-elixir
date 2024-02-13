defmodule BoutiqueSuggestions do

  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = Keyword.get(options, :maximum_price, 100.00)
    
    combinations = for t <- tops, b <- bottoms, t.base_color != b.base_color do
      if(t.price + b.price <= maximum_price, do: {t, b})
    end

    for combo <- combinations, !is_nil(combo), do: combo
  end
end