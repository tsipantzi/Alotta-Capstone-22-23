package liberty.capstone.example;

import org.springframework.data.jpa.repository.JpaRepository;
import List.java.util;

public interface CouponDao extends JpaRepository<Coupon, Long> {
    List<CouponEntity>findAllCouponsByCouponType(String couponType);
    List<CouponEntity>findAllCouponsByPercentageOff(Long percentageOff);
    List<CouponEntity>findAllCouponsByDollarsOff(Long dollarsOff);
    List<CouponEntity>findAllCouponsBycouponInfo(String couponInfo);
    List<CouponEntity>findAllCouponsByFoodCategories(String foodCategories);
    List<CouponEntity>findAllCouponsByNumberOfCouponsPerCustomer(Long numberOfCouponsPerCustomer);
    List<CouponEntity>findAllCouponsByTotalNumberOfCoupons(Long totalNumberOfCoupons);
    List<CouponEntity>findAllCouponsByNumberOfCouponsSold(Long numberOfCouponsSold);    
}
