require_relative 'item'
require 'csv'

# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

class ItemRepository

  attr_reader :all

  def initialize(se, item_csv)
    @all = []
    @se = se
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      @all << Item.load_csv(row)
    end
  end

  def find_by_id(id)
    all.each do |item|
      return item if item.id == id
    end
    nil
  end

  def find_by_name(name)
    all.each do |item|
      return item if item.name.downcase == name.downcase
    end
    nil
  end

  def find_all_with_description(description)
    item_array = []
    all.each do |item|
      item_array << item if item.description.downcase.include?(description.downcase)
    end
    item_array
  end

  def find_by_price(price)
    item_array = []
    all.each do |item|
      item_array << item if item.unit_price == price
    end
    item_array
  end

  def find_all_by_price_in_range(price_range)
    item_array = []
    all.each do |item|
      item_array << item if price_range.any? {|num| num == item.unit_price}
    end
    item_array
  end

  def find_all_by_merchant_id(merchant_id)
  merchant_id_array = []
  all.each do |item|
    if item.merchant_id == merchant_id
      merchant_id_array << item
    end
  end
    return merchant_id_array
  end

end
