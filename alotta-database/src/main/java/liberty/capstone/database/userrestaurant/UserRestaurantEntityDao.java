package liberty.capstone.database.userrestaurant;

import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRestaurantEntityDao extends JpaRepository<UserRestaurantEntity, Long> {
    List<UserRestaurantEntity> findAllByAppUserIs(AppUserEntity appUser);
    Optional<UserRestaurantEntity> findByAppUserIsAndRestaurantIs(AppUserEntity appUser,
                                                              RestaurantEntity restaurant);

}
