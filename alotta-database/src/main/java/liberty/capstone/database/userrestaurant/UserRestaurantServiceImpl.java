package liberty.capstone.database.userrestaurant;

import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;

import liberty.capstone.database.appuser.AppUserDao;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.var;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserRestaurantServiceImpl implements UserRestaurantService {
    private final RestaurantEntityDao restaurantDao;
    private final AppUserDao userDao;
    private final UserRestaurantEntityDao userRestaurantDao;

    @Override
    public List<UserRestaurant> getRestaurantsByUsername(final String username) {
        final var users = userDao.findAllByUsername(username);
        if (users.isEmpty()) {
            throw new IllegalArgumentException("Could not find user");
        }
        final var user = users.get(0);

        return userRestaurantDao.findAllByUserIs(user).stream()
                    .map(this::toUserRestaurantObject)
                    .collect(Collectors.toList());
    }

    @Override
    public UserRestaurant saveRestaurant(final UserRestaurant userRestaurant) {
        final var users = userDao.findAllByUsername(userRestaurant.getAppUser().getUsername());
        if (users.isEmpty()) {
            throw new IllegalArgumentException("Could not find user");
        }
        final var user = users.get(0).toDomainObject();
        
        final var restaurant = restaurantDao.save(new RestaurantEntity(userRestaurant.getRestaurant())).toDomainObject();
        return new UserRestaurant(user, restaurant);
    }

    private UserRestaurant toUserRestaurantObject(final UserRestaurantEntity entity) {
        return new UserRestaurant(entity.getAppuser().toDomainObject(), entity.getRestaurant().toDomainObject());
    }

}
