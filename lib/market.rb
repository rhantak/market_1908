require './lib/vendor'
require 'pry'

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    selling_vendors = []
    @vendors.each do |vendor|
      if vendor.inventory.keys.include?(item)
        selling_vendors << vendor
      end
    end
  end
end
