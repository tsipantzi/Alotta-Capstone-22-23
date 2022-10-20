package liberty.capstone.core.restaurantinventory;

import java.util.List;

public interface RestaurantInventoryService {
    List<RestaurantInventory> getRestaurantInventoryById(Long id);

    RestaurantInventory saveInventoryItem(Long id, RestaurantInventory item);

}
