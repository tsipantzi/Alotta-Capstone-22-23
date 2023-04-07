package liberty.capstone.core.customerinventory;

import java.util.List;

import liberty.capstone.core.coupon.Coupon;


public interface CustomerInventoryService {
    List<Coupon> findAllByUserIs(Long userId);
    CustomerInventory saveCouponForCustomer(Long userId, Long couponId);

    boolean redeemCoupon(Long userId,
                         Long couponId);
}
