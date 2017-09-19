require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class TestSalesAnalyst < Minitest::Test

  attr_reader :sa

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./test/test_fixtures/invoice_items_medium.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_its_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_averages_items_per_merchant
    assert_equal 2.03, sa.average_items_per_merchant
  end

  def test_it_takes_a_standard_deviation
    assert_equal 2.45, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal BigDecimal.new(10.25, 4), sa.average_item_price_for_merchant(12334185)
  end

  def test_it_sums_averages_across_merchants_and_averages
    assert_equal BigDecimal.new(241.9, 4), sa.average_average_price_per_merchant
  end

  def test_it_returns_golden_items
    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
  end

  def test_it_returns_top_merchants_by_invoice
    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
  end

  def test_it_finds_percent_status
    assert_equal 29.64, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.41, sa.invoice_status(:returned)
  end

  def test_it_checks_if_invoice_is_paid_in_full
    assert sa.sales_engine.invoices.all[1].is_paid_in_full?
    refute sa.sales_engine.invoices.all[0].is_paid_in_full?
  end

  ##### Iteration 4 #####

  def test_can_check_if_merchant_is_pending
    assert sa.pending?(12334149)
    refute sa.pending?(12334105)
  end

  def test_it_finds_merchants_with_pending_invoices
    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

  def test_finds_merchants_with_only_one_item
    assert_instance_of Array, sa.merchants_with_only_one_item
    assert_instance_of Merchant, sa.merchants_with_only_one_item[0]
    assert_equal 1, sa.merchants_with_only_one_item[0].items.count
  end

  def test_it_returns_bottom_merchants_by_invoice
    assert_instance_of Array, sa.bottom_merchants_by_invoice_count

    #to test 2 STD below, use Whole invoice csv
    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count[0]
  end

  def test_it_returns_top_days_by_invoice
    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
  end

  def test_it_finds_top_days_by_invoice_count
    assert_equal [], sa.top_days_by_invoice_count
  end


end
