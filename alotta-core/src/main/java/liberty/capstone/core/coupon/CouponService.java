package liberty.capstone.core.coupon;

import java.time.LocalDate;
import java.util.List;

public interface CouponService {
    List<Coupon> getAllCouponsForRestaurant(Long restaurantId);

    Coupon getCouponForRestaurant(Long couponId);

    Coupon saveCoupon(Long restaurantId, Coupon coupon, LocalDate startDate, LocalDate endDate);
}
