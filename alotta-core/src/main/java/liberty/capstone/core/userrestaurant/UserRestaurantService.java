package liberty.capstone.core.userrestaurant;

import java.util.List;

public interface UserRestaurantService {
    List<UserRestaurant> getRestaurantsByUsername(String username);

    UserRestaurant saveRestaurant(UserRestaurant userRestaurant);
}
