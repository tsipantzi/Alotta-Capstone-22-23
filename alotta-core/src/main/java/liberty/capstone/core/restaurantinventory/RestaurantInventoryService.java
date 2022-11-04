package liberty.capstone.core.restaurantinventory;

import java.time.LocalDate;
import java.util.List;

public interface RestaurantInventoryService {
    List<RestaurantInventory> getRestaurantInventoryById(Long restaurantId);

    RestaurantInventory saveInventoryItem(Long restaurantId,
                                          Long couponId,
                                          LocalDate startDate,
                                          LocalDate endDate);
}
