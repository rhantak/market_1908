require './lib/vendor'
require './lib/market'
require 'minitest/autorun'
require 'minitest/pride'

class MarketTest < Minitest::Test
  def setup
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @market = Market.new("South Pearl Street Farmers Market")
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_initialize
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors
    @market.add_vendor(@vendor1)
    assert_equal [@vendor1], @market.vendors

    @market.add_vendor(@vendor2)
    assert_equal [@vendor1, @vendor2], @market.vendors
  end

  def test_it_can_return_vendor_names
    @market.add_vendor(@vendor1)
    assert_equal ["Rocky Mountain Fresh"], @market.vendor_names

    @market.add_vendor(@vendor2)
    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom"], @market.vendor_names
  end

  def test_it_can_find_vendors_that_sell_a_specific_item
    @vendor1.stock("Peaches", 35)
    @vendor1.stock("Tomatoes", 7)
    @vendor2.stock("Banana Nice Cream", 50)
    @vendor2.stock("Peaches", 2)
  end
end
