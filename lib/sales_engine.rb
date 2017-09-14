<<<<<<< HEAD
require_relative "item_repository"
require_relative "merchant_repository"
=======
require_relative 'item_repository'
require_relative 'merchant_repository'
>>>>>>> 09b7e857f43dd6612eb45abe27620499823d22d6

class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(file_names)
    @item_file = file_names[:items]
    @merchant_file = file_names[:merchants]
    SalesEngine.new(@item_file, @merchant_file)
  end

  def initialize(item_csv, merchant_csv)
    @items = ItemRepository.new(self, item_csv)
    @merchants = MerchantRepository.new(self, merchant_csv)
  end

end
