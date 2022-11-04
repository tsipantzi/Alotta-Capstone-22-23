package liberty.capstone.database.coupon;

import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "coupon")
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

    @OneToMany(mappedBy = "coupon")
    private List<RestaurantInventoryEntity> inventory = new ArrayList<>();

    public void addInventory(final RestaurantInventoryEntity inventoryItem) {
        inventory.add(inventoryItem);
        inventoryItem.setCoupon(this);
    }

    public void removeInventory(final RestaurantInventoryEntity inventoryItem) {
        inventory.remove(inventoryItem);
        inventoryItem.setCoupon(null);
    }
}
