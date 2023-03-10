package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity
@Slf4j
@NoArgsConstructor
@Table(name = "RestaurantInventory")
public class RestaurantInventoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @JoinColumn(referencedColumnName = "id")
    @OneToOne(fetch = FetchType.LAZY)
    private CouponEntity coupon;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private RestaurantEntity restaurant;
    private LocalDate startDate;
    private LocalDate endDate;

    public RestaurantInventory toDomainObject() {
        final var restaurantInventory = new RestaurantInventory();
        restaurantInventory.setRestaurant(restaurant.toDomainObject());
        restaurantInventory.setCoupon(coupon.toDomainObject());
        restaurantInventory.setStartDate(startDate);
        restaurantInventory.setEndDate(endDate);
        log.info("Converted RestaurantInventory to domain object : {}", restaurantInventory);
        return restaurantInventory;
    }

    public String toString() {
        return String.format("""
                RestaurantInventoryEntity[
                    id: %s,
                    restaurant: %s,
                    coupon: %s,
                    startDate: %s,
                    endDate: %s
                ]
                """, id, coupon, restaurant, startDate, endDate);

    }
}
