package liberty.capstone.database.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "Coupon")
@NoArgsConstructor
public class CouponEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @OneToMany(mappedBy = "coupon")
    private List<RestaurantInventoryEntity> inventory = new ArrayList<>();

    public CouponEntity(final Coupon domainObject) {
        this.title = domainObject.getTitle();
        this.couponType = domainObject.getCouponType();
        this.percentageOff = domainObject.getPercentageOff();
        this.dollarsOff = domainObject.getDollarsOff();
        this.couponInfo = domainObject.getCouponInfo();
        this.foodCategories = domainObject.getFoodCategories();
        this.numberOfCouponsPerCustomer = domainObject.getNumberOfCouponsPerCustomer();
        this.totalNumberOfCoupons = domainObject.getTotalNumberOfCoupons();
        this.numberOfCouponsSold = domainObject.getNumberOfCouponsSold();
        this.startDate = domainObject.getStartDate();
        this.endDate = domainObject.getEndDate();
    }

    public Coupon toDomainObject() {
        final Coupon domainObject = new Coupon();
        domainObject.setTitle(domainObject.getTitle());
        domainObject.setCouponType(domainObject.getCouponType());
        domainObject.setPercentageOff(domainObject.getPercentageOff());
        domainObject.setDollarsOff(domainObject.getDollarsOff());
        domainObject.setCouponInfo(domainObject.getCouponInfo());
        domainObject.setFoodCategories(domainObject.getFoodCategories());
        domainObject.setNumberOfCouponsPerCustomer(domainObject.getNumberOfCouponsPerCustomer());
        domainObject.setTotalNumberOfCoupons(domainObject.getTotalNumberOfCoupons());
        domainObject.setNumberOfCouponsSold(domainObject.getNumberOfCouponsSold());
        domainObject.setStartDate(domainObject.getStartDate());
        domainObject.setEndDate(domainObject.getEndDate());
        return domainObject;
    }
}
