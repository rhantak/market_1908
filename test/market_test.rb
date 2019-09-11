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
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @vendor1.stock("Peaches", 35)
    @vendor1.stock("Tomatoes", 7)
    @vendor2.stock("Banana Nice Cream", 50)
    @vendor2.stock("Peaches", 2)

    assert_equal [@vendor2], @market.vendors_that_sell("Banana Nice Cream")
    assert_equal [@vendor1, @vendor2], @market.vendors_that_sell("Peaches")
  end

  def test_it_can_return_a_sorted_item_list
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @vendor1.stock("Peaches", 35)
    @vendor1.stock("Tomatoes", 7)
    @vendor2.stock("Banana Nice Cream", 50)
    @vendor2.stock("Peaches", 2)

    expected = ["Banana Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected, @market.sorted_item_list
  end

  def test_it_can_return_total_inventory
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @vendor1.stock("Peaches", 35)
    @vendor1.stock("Tomatoes", 7)
    @vendor2.stock("Banana Nice Cream", 50)
    @vendor2.stock("Peaches", 2)

    expected = {"Peaches" => 37, "Tomatoes" => 7, "Banana Nice Cream" => 50}
    assert_equal expected, @market.total_inventory
  end


end
