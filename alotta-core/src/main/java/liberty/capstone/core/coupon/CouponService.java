package liberty.capstone.core.coupon;

import java.util.List;

public interface CouponService {
    Coupon findCouponById(Long couponId);
    List<Coupon> findAllCoupons();

    List<Coupon> findAllCouponsBySearchTerm(String searchTerm);

    List<Coupon> getAllCouponsByOptions(final CouponSearchOptions options);
}
