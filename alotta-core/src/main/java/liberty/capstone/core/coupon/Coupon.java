package liberty.capstone.core.coupon;

import lombok.Data;

import java.time.LocalDate;

@Data
public class Coupon {
    private Long id;
    private String title;
    private String couponType;
    private Long percentageOff;
    private Long dollarsOff;
    private String couponInfo;
    private String foodCategories;
    private Long numberOfCouponsPerCustomer;
    private Long totalNumberOfCoupons;
    private Long numberOfCouponsSold;
    private LocalDate startDate;
    private LocalDate endDate;
}
