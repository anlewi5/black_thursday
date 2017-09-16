require_relative 'item_repository'
require 'bigdecimal'
require 'time'
require 'pry'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :unit_price_float,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repository

  def initialize(item_repositoryr, csv_info)
    @id = csv_info[:id].to_i
    @name = csv_info[:name]
    @description = csv_info[:description]
    @unit_price = unit_price_to_dollars(csv_info[:unit_price])
    @unit_price_float = (csv_info[:unit_price]).to_f
    @created_at = Time.parse(csv_info[:created_at].to_s)
    @updated_at = Time.parse(csv_info[:updated_at].to_s)
    @merchant_id = csv_info[:merchant_id].to_i
    @item_repository = item_repository
  end

  def unit_price_to_dollars(unit_price)
    dollars = unit_price.to_f / 100
    BigDecimal.new(dollars, 4)
  end

  def merchant
     #merchant_repository.sales_engine.items.find_all_by_merchant_id(id)
     #item_repository.se.merchants.find_by_id(id)

     id = merchant_id.to_i

     return 0 if id.nil?
     se = item_repository.se
     merchants = se.merchants
     #binding.pry
     merchants.find_by_id(id)
  end

end
