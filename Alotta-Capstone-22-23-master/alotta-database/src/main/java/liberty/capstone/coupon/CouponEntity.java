package liberty.capstone.coupon;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "coupon")
public class CouponEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
