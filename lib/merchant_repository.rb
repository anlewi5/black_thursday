require "csv"
require_relative "merchant"
require_relative "sales_engine"


class MerchantRepository

  attr_reader :all, :sales_engine

  def initialize(sales_engine, merchant_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(merchant_csv, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(self, row)
    end
    @id = :id
    @name = :name
  end


  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


  def find_by_id(id)
    all.each do |merchant|
      return merchant if merchant.id == id
    end
    nil
  end

  def find_by_name(name)
    all.each do |merchant|
      return merchant if merchant.name.downcase == name.downcase
    end
    nil
  end

  def find_all_by_name(name)
    merchant_array = []
    all.each do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        merchant_array << merchant
      end
    end
    return merchant_array
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def merchants_registered_in_month(month)
    all.map do |merchant|
      puts merchant.created_at
    end
  end

end
