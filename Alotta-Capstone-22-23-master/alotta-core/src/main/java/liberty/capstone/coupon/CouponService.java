package liberty.capstone.core.coupon;

import java.util.List;

public interface CouponService {
    List<Coupon> findCouponsByType(String type);

    Coupon saveCoupon(Coupon coupon);
}