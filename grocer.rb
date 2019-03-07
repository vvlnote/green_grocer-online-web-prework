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
      item_data[:price] *= 0.8
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
