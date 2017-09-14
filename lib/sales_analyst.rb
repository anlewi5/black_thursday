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
    # binding.pry
    average = average_items_per_merchant
    item_counts = hash_of_merchants_and_number_of_items
    # item_counts: {merchant_id => #items, ...}
    individual_minus_average = item_counts.values.map do |number_of_items|
                                 number_of_items - average
                               end
    individual_minus_average_squared = individual_minus_average.map {|num| num ** 2}
    std_dev_top = individual_minus_average_squared.sum
    Math.sqrt(std_dev_top / 2)
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
   item_counts
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
