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
    @vendors.find_all {|vendor| vendor.inventory.include?(item)}
  end

  def sorted_item_list
    list = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |key|
        list << key
      end
    end
    list.uniq.sort
  end

  def total_inventory
    total_inv = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        total_inv[item] += amount
      end
    end
    total_inv
  end

  def sell(item, amount)
    if total_inventory[item] < amount
      false
    else
      remaining_order = amount
      vendors_that_sell(item).each do |vendor|
        if remaining_order >= vendor.inventory[item]
          remaining_order -= vendor.inventory[item]
          vendor.inventory[item] = 0
        elsif remaining_order < vendor.inventory[item]
          vendor.inventory[item] -= remaining_order
          remaining_order = 0
        end
      end
    end
  end
end
