package liberty.capstone.core.restaurantinventory;

import com.fasterxml.jackson.annotation.JsonFormat;
import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RestaurantInventory {
    private Coupon coupon;
    private Restaurant restaurant;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;
}
