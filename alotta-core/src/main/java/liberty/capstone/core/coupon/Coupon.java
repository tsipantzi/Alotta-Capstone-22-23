package liberty.capstone.core.coupon;

import lombok.Data;

@Data
public class Coupon {
    private Long id;
    private String couponType;
    private Long percentageOff;
    private Long dollarsOff;
    private String couponInfo;
    private String foodCategories;
    private Long numberOfCouponsPerCustomer;
    private Long totalNumberOfCoupons;
    private Long numberOfCouponsSold;
}
