package liberty.capstone.database.userrestaurant;

import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;
import liberty.capstone.database.appuser.AppUserDao;
import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserRestaurantServiceImpl implements UserRestaurantService {
    private static final String COULD_NOT_FIND_USER = "Could not find user %s";
    private final RestaurantEntityDao restaurantDao;
    private final AppUserDao userDao;
    private final UserRestaurantEntityDao userRestaurantDao;

    @Override
    public List<UserRestaurant> getRestaurantsByUsername(final String username) {
        final var users = userDao.findAllByUsername(username);
        if (users.isEmpty()) {
            throw new IllegalArgumentException(String.format(COULD_NOT_FIND_USER, username));
        }
        final var user = users.get(0);

        return userRestaurantDao.findAllByAppUserIs(user).stream()
                    .map(this::toUserRestaurantObject)
                    .collect(Collectors.toList());
    }

    @Override
    public UserRestaurant saveRestaurant(final UserRestaurant userRestaurant) {
        final List<AppUserEntity> users = userDao.findAllByUsername(userRestaurant.getAppUser().getUsername());
        if (users.isEmpty()) {
            throw new IllegalArgumentException(String.format(COULD_NOT_FIND_USER,
                    userRestaurant.getAppUser().getUsername()));
        }
        final var user = users.get(0).toDomainObject();
        
        final var restaurant = restaurantDao.save(new RestaurantEntity(userRestaurant.getRestaurant()))
                .toDomainObject();

        return new UserRestaurant(user, restaurant);
    }

    private UserRestaurant toUserRestaurantObject(final UserRestaurantEntity entity) {
        return new UserRestaurant(entity.getAppUser().toDomainObject(), entity.getRestaurant().toDomainObject());
    }

}
