package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.database.restaurant.RestaurantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RestaurantInventoryEntityDao extends JpaRepository<RestaurantInventoryEntity, Long> {
    List<RestaurantInventoryEntity> findAllByRestaurantIs(RestaurantEntity restaurant);
}
