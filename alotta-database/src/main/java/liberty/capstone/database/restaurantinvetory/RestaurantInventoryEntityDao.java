package liberty.capstone.database.restaurantinvetory;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

@SuppressWarnings({"MethodName", "PMD.MethodNamingConventions"})
public interface RestaurantInventoryEntityDao extends JpaRepository<RestaurantInventoryEntity, Long> {
    List<RestaurantInventoryEntity> findAllByRestaurant_Id(Long restaurantId);
}
