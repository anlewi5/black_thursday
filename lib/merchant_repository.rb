#Lauren doing this one!

=begin
The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:

all - returns an array of all known Merchant instances
find_by_id - returns either nil or an instance of Merchant with a matching ID
  -- for each instance, check the id. use .find?
find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive

=end
require "csv"
require_relative "merchant"
require_relative "sales_engine"


class MerchantRepository

  attr_reader :all

  def initialize(se, merchant_csv)
    @all = []
    @se = se

    CSV.foreach(merchant_csv, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(self, row)
    end

    @id = :id
    @name = :name
  end



  # def find_by_id(id)
  #   all.find(id)
  # end
  #
  # def find_by_name
  # end
  #
  # def find_all_by_name
  # end




end