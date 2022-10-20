package liberty.capstone.database.restaurantinvetory;

import org.springframework.data.jpa.repository.JpaRepository;

public interface RestaurantInventoryEntityDao extends JpaRepository<RestaurantInventoryEntity, Long> {
}
