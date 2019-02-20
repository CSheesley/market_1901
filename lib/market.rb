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
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    item_seller = []
    @vendors.each do |vendor|
      if vendor.inventory.has_key?(item)
        item_seller << vendor
      else
      end
    end
    item_seller
  end

  def sorted_item_list
    all_items = []
    @vendors.each do |vendor|
      all_items << vendor.inventory.keys
    end
    all_items.flatten!
    alpha_sorted = all_items.uniq.sort
    alpha_sorted
  end

  def total_inventory
    all_inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        all_inventory[item] = 0 #makes me think an inject method would be better
      end
    end
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        all_inventory[item] += quantity
      end
    end
    all_inventory
  end

  def sell(item, quantity) #refactor
    if total_inventory[item].nil?
      false
    else
      if total_inventory[item] >= quantity
        take_from_vendor(item, quantity) #helper method
      else
        false
      end
    end
  end

  def take_from_vendor(item, quantity)
    vendors_that_sell(item).each do |vendor|
      vendor.inventory[item] -= quantity

      # take from vendor one at a time until vendor level == 0
      # reduce quanity by one each time
      # iterate over vendors_that_sell has until quantity == 0

    end
    true
  end

end
