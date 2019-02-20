require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'

class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")

    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_begins_with_no_vendors
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors_and_find_out_information_about_vendors
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)

    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)

    @vendor_3.stock("Peaches", 65)

    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_2, @vendor_3], @market.vendors

    names = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal names, @market.vendor_names

    assert_equal [@vendor_1, @vendor_3], @market.vendors_that_sell("Peaches")
    assert_equal [@vendor_2], @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_it_can_determine_the_inventory_of_all_items_at_the_market
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)

    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)

    @vendor_3.stock("Peaches", 65)

    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)


    expected_1 = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected_1, @market.sorted_item_list

    expected_2 = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    assert_equal expected_2, @market.total_inventory
  end

  def test_it_can_sell_items
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)

    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)

    @vendor_3.stock("Peaches", 65)

    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal false, @market.sell("Peaches", 200)

    assert_equal false, @market.sell("Onions", 1)

    assert_equal true, @market.sell("Banana Nice Cream", 5)

    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")

    assert_equal true, @market.sell("Peaches", 40)

    assert_equal 0, @vendor_1.check_stock("Peaches")  # wont pass yet

    assert_equal 60, @vendor_3.check_stock("Peaches") # wont pass yet
  end

end
