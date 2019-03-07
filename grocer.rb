def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |item|
    if consolidated_cart.has_key?(item.keys[0])
      consolidated_cart[item.keys[0]][:count] += 1
    else
      consolidated_cart[item.keys[0]] = item.values[0]
      consolidated_cart[item.keys[0]][:count] = 1
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item])
      count = 0
      while cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]
        count += 1
      end
      if count > 0
        new_key = coupon[:item] + " W/COUPON"
        new_attribute = {}
        new_attribute[:price] = coupon[:cost]
        new_attribute[:clearance] = cart[coupon[:item]][:clearance]
        new_attribute[:count] = count
        cart[new_key] = new_attribute
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, item_data|
    if item_data[:clearance]
      item_data[:price] = (item_data[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total_cost = 0
  consolidated_cart = {}
  consolidated_cart = consolidate_cart(cart)
  puts "after consolidated - #{consolidated_cart}"
  consolicated_cart = apply_coupons(consolidated_cart, coupons)
  puts "after coupons - #{consolidated_cart}"
  consolidated_cart = apply_clearance(consolidated_cart)
  puts "after clearance -#{consolidated_cart}"
  item_name = ""
  for i in 0...consolidated_cart.length
    item_name = consolidated_cart.keys[i]
    total_cost += (consolidated_cart[item_name][:price] * consolidated_cart[item_name][:count]).round(2)
  end
  if total_cost > 100
    total_cost = (total_cost * 0.9).round(2)
  end
  total_cost
end
