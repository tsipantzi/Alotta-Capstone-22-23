package liberty.capstone.core.coupon;

import liberty.capstone.core.restaurantinventory.RestaurantInventory;

import java.util.List;

public interface CouponService {
    List<Coupon> getAllCouponsForRestaurant(Long restaurantId);

    RestaurantInventory saveCoupon(Long restaurantId, Coupon coupon);
}
