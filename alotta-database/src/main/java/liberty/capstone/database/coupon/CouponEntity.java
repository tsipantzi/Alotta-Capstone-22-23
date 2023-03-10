package liberty.capstone.database.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "Coupon")
@NoArgsConstructor
@Slf4j
@ToString
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

    @OneToOne(mappedBy = "coupon")
    @ToString.Exclude
    private RestaurantInventoryEntity inventory;

    public CouponEntity(final Coupon domainObject) {
        this.id = domainObject.getId();
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
        domainObject.setId(id);
        domainObject.setTitle(title);
        domainObject.setCouponType(couponType);
        domainObject.setPercentageOff(percentageOff);
        domainObject.setDollarsOff(dollarsOff);
        domainObject.setCouponInfo(couponInfo);
        domainObject.setFoodCategories(foodCategories);
        domainObject.setNumberOfCouponsPerCustomer(numberOfCouponsPerCustomer);
        domainObject.setTotalNumberOfCoupons(totalNumberOfCoupons);
        domainObject.setNumberOfCouponsSold(numberOfCouponsSold);
        domainObject.setStartDate(startDate);
        domainObject.setEndDate(endDate);
        log.info("Converted CouponEntity to domain object : {}", domainObject);
        return domainObject;
    }
}
