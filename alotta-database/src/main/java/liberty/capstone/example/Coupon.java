package liberty.capstone.example;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "example")
public class Coupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long CouponId;
    private String CouponType;
    private float PercentageOff;
    private float DollarsOff;
    private String CouponInfo;
    private String FoodCategories;
    private int NumberOfCouponsPerCustomer;
    private int TotalNumberOfCoupons;
    private int NumberOfCouponsSold;
}
