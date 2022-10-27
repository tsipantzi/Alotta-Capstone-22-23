package liberty.capstone.core.restaurant;

import java.util.List;

public interface RestaurantService {
    List<Restaurant> findRestaurantsByName(String name);

    Restaurant saveRestaurant(Restaurant restaurant);
}
