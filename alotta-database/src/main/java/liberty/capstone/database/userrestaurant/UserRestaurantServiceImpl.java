package liberty.capstone.database.userrestaurant;

import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;
import liberty.capstone.database.appuser.AppUserDao;
import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import org.h2.engine.User;
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
    public List<UserRestaurant> getRestaurantsForUserByUserId(final Long id) {
        final var user = userDao.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Could not find a user for the given ID"));

        return userRestaurantDao.findAllByAppUserIs(user).stream()
                    .map(this::toUserRestaurantObject)
                    .collect(Collectors.toList());
    }

    @Override
    public UserRestaurant saveRestaurant(final UserRestaurant userRestaurant) {
        final AppUserEntity appUser = userDao.findById(userRestaurant.getAppUser().getId())
                .orElseThrow(() ->
                        new IllegalArgumentException(String.format(COULD_NOT_FIND_USER,
                                userRestaurant.getAppUser().getUsername())));
        
        final var restaurant = restaurantDao.saveAndFlush(new RestaurantEntity(userRestaurant.getRestaurant()));

        final var savedUserRestaurant = userRestaurantDao.saveAndFlush(new UserRestaurantEntity(appUser, restaurant));

        return savedUserRestaurant.toDomainObject();
    }

    @Override
    public UserRestaurant updateRestaurant(final UserRestaurant userRestaurant) {
        final AppUserEntity appUser = userDao.findById(userRestaurant.getAppUser().getId())
                .orElseThrow(() ->
                        new IllegalArgumentException(String.format(COULD_NOT_FIND_USER,
                                userRestaurant.getAppUser().getUsername())));

        restaurantDao.findById(userRestaurant.getRestaurant().getId())
                .orElseThrow(() ->
                        new IllegalArgumentException("Could not find the specified restaurant for that user"));

        final var restaurant = restaurantDao.saveAndFlush(new RestaurantEntity(userRestaurant.getRestaurant()));

        final var savedUserRestaurant = userRestaurantDao.saveAndFlush(new UserRestaurantEntity(appUser, restaurant));

        return savedUserRestaurant.toDomainObject();
    }

    private UserRestaurant toUserRestaurantObject(final UserRestaurantEntity entity) {
        return new UserRestaurant(entity.getAppUser().toDomainObject(), entity.getRestaurant().toDomainObject());
    }

}
