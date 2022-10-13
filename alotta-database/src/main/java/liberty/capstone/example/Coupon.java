package liberty.capstone.example;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "coupon")
public class Coupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long CouponId;
    private String CouponType;
    private Long PercentageOff;
    private Long DollarsOff;
    private String CouponInfo;
    private String FoodCategories;
    private Long NumberOfCouponsPerCustomer;
    private Long TotalNumberOfCoupons;
    private Long NumberOfCouponsSold;
}
