package liberty.capstone.core.userrestaurant;

import java.util.List;

public interface UserRestaurantService {
    List<UserRestaurant> getRestaurantsForUserByUserId(Long id);

    UserRestaurant saveRestaurant(UserRestaurant userRestaurant);

    UserRestaurant updateRestaurant(UserRestaurant userRestaurant);
}
