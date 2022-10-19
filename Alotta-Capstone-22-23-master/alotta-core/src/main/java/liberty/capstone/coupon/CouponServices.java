package liberty.capstone.example;

import java.util.List;

public interface CouponServices {
    List<Coupon> findCouponsByCouponType(String couponType);

    Coupon save(String couponType);

    List<Coupon>findCouponsByPercentageOff(Long percentageOff);

    Coupon save(Long percentageOff);

    List<Coupon> findCouponsByDollarsOff(Long dollarsOff);

    Coupon save(Long dollarsOff);

    List<Coupon> findCouponsByCouponInfo(String couponInfo);

    Coupon save(String couponInfo);

    List<Coupon> findCouponsByFoodCategories(String foodCategories);

    Coupon save(String foodCategories);

    List<Coupon> findCouponsByNumberOfCouponsPerCustome(Long numberOfCouponsPerCustomer);

    Coupon save(Long numberOfCouponsPerCustomer);

    List<Coupon> findCouponsByTotalNumberOfCoupons(Long totalNumberOfCoupons);

    Coupon save(Long totalNumberOfCoupons);

    List<Coupon> findCouponsByNumberOfCouponsSold(Long numberOfCouponsSold);

    Coupon save(Long numberOfCouponsSold);
}
