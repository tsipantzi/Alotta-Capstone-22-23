package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "RestaurantInventory")
public class RestaurantInventoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private CouponEntity coupon;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private RestaurantEntity restaurant;
    private LocalDate startDate;
    private LocalDate endDate;
}
