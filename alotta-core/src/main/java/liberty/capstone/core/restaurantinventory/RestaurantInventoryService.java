package liberty.capstone.core.restaurantinventory;

import liberty.capstone.core.coupon.Coupon;

import java.util.List;

public interface RestaurantInventoryService {
    List<Coupon> findAllCouponsByRestaurantId(Long restaurantId);
    Coupon saveCoupon(Long restaurantId, Coupon coupon);
}
