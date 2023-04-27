package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

@SuppressWarnings({"MethodName", "PMD.MethodNamingConventions"})
public interface RestaurantInventoryEntityDao extends JpaRepository<RestaurantInventoryEntity, Long> {
    List<RestaurantInventoryEntity> findAllByRestaurant_Id(Long restaurantId);

    Optional<RestaurantInventoryEntity> findByRestaurantAndCoupon(RestaurantEntity restaurant, CouponEntity coupon);
}
