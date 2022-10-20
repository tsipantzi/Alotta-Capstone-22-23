package liberty.capstone.core.restaurantinventory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RestaurantInventory {
    private Coupon coupon;
    private Restaurant restaurant;
    private LocalDate startDate;
    private LocalDate endDate;
}
