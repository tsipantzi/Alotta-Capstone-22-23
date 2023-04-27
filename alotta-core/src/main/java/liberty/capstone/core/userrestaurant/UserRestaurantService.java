package liberty.capstone.core.userrestaurant;

import liberty.capstone.core.restaurant.Restaurant;

import java.util.List;

public interface UserRestaurantService {
    List<UserRestaurant> getRestaurantsForUserByUserId(Long id);

    List<Restaurant> getAllRestaurantsForZipCode(String zipCode);

    UserRestaurant saveRestaurant(UserRestaurant userRestaurant);

    UserRestaurant updateRestaurant(UserRestaurant userRestaurant);

    void deleteRestaurant(UserRestaurant userRestaurant);
}
