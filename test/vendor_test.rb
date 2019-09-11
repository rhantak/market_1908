require './lib/vendor'
require 'minitest/autorun'
require 'minitest/pride'

class VendorTest < Minitest::Test
  def setup
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor1
  end

  def test_initialize
    assert_equal @vendor1.name, "Rocky Mountain Fresh"
    assert_equal @vendor1.inventory, ({})
  end

  def test_it_can_check_stock_of_one_item
    assert_equal @vendor1.check_stock("Peaches"), 0
  end

  def test_it_can_stock_items
    @vendor1.stock("Peaches", 30)
    assert_equal @vendor1.check_stock("Peaches"), 30

    @vendor1.stock("Peaches", 30)
    assert_equal @vendor1.check_stock("Peaches"), 60

    @vendor1.stock("Oranges", 30)
    assert_equal @vendor1.check_stock("Oranges"), 30
  end

  def test_it_can_print_its_inventory
    @vendor1.stock("Peaches", 30)
    @vendor1.stock("Oranges", 30)

    assert_equal @vendor1.inventory, ({"Peaches" => 30, "Oranges" => 30})
  end
end
