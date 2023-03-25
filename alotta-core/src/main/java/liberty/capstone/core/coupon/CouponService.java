package liberty.capstone.core.coupon;

import java.util.List;

public interface CouponService {
    Coupon findCouponById(Long couponId);
    List<Coupon> findAllCoupons();

    List<Coupon> findAllCouponsBySearchTermAndZipCode(String searchTerm, String zipCode);

    List<Coupon> getAllCouponsByZipCode(String zipCode);
}
