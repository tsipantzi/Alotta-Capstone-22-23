package liberty.capstone.core.coupon;

import liberty.capstone.core.appuser.AppUser;

import java.util.List;

public interface CouponService {
    Coupon findCouponById(Long couponId);
    List<Coupon> findAllCoupons();

    List<Coupon> findAllCouponsBySearchTermAndZipCode(String searchTerm, AppUser user);

    List<Coupon> getAllCouponsByZipCode(AppUser user);
}
