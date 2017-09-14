require_relative "sales_engine"


class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    item_counts = hash_of_merchants_and_number_of_items
    total_items = item_counts.values.sum
    total_merchants = item_counts.length
    (total_items/total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    #item_counts = hash_of_merchants_and_number_of_items
    # item_counts: {merchant_id => #items, ...}
    individual_minus_average = []
    individual_minus_average << hash_of_merchants_and_number_of_items.values.map do |number_of_items|
                                 #binding.pry
                                 number_of_items - average
                               end
    individual_minus_average_squared = individual_minus_average.flatten.map {|num| num ** 2}
    std_dev_top = individual_minus_average_squared.sum
    number_of_elements = hash_of_merchants_and_number_of_items.values.count
    Math.sqrt(std_dev_top / (number_of_elements - 1)).round(2)

    # Work out the Mean (the simple average of the numbers)
    # Then for each number: subtract the Mean and square the result (the squared difference).
    # Then work out the average of those squared differences. (this is the variance.)
    # Then take the square root of the variance.
  end

  def hash_of_merchants_and_number_of_items
    item_array = se.items.all
    merchant_ids = item_array.map do |item|
                     item.merchant_id
                   end
   item_counts = Hash.new 0
   merchant_ids.each do |merchant_id|
     item_counts[merchant_id] += 1.0
   end
   return item_counts
  end

  def std_dev
    average_items_per_merchant_standard_deviation
  end


  def merchants_with_high_item_count
    merchant_ids = []

    item_counts = hash_of_merchants_and_number_of_items
    one_above  = average_items_per_merchant + std_dev
    item_counts.each do |key,value|
      merchant_ids << key.to_i if  value > one_above
    end
            # binding.pry
    merchants = []
    merchant_ids.each do |id|
      merchants << se.merchants.find_by_id(id)
    end
    merchants
  end


end