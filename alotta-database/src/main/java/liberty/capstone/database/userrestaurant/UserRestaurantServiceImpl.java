package liberty.capstone.database.userrestaurant;

import liberty.capstone.core.restaurant.Restaurant;
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
    public static final String COULD_NOT_FIND_RESTAURANT = "Could not find the specified restaurant %s";
    private final RestaurantEntityDao restaurantDao;
    private final AppUserDao userDao;
    private final UserRestaurantEntityDao userRestaurantDao;

    @Override
    public List<UserRestaurant> getRestaurantsForUserByUserId(final Long id) {
        final var user = userDao.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Could not find a user for the given ID"));

        return userRestaurantDao.findAllByAppUserIs(user).stream()
                    .map(UserRestaurantEntity::toDomainObject)
                    .collect(Collectors.toList());
    }

    @Override
    public List<Restaurant> getAllRestaurantsForZipCode(final String zipCode) {
        return restaurantDao.findAllByZipCodeLike(zipCode.substring(0, zipCode.length() - 2))
                .stream()
                .map(RestaurantEntity::toDomainObject)
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

    @Override
    public void deleteRestaurant(final UserRestaurant userRestaurant) {
        final AppUserEntity appUser = userDao.findById(userRestaurant.getAppUser().getId())
                .orElseThrow(() ->
                        new IllegalArgumentException(String.format(COULD_NOT_FIND_USER,
                                userRestaurant.getAppUser().getUsername())));

        final var restaurantEntity = restaurantDao.findById(userRestaurant.getRestaurant().getId())
                .orElseThrow(() ->
                        new IllegalArgumentException(String.format(COULD_NOT_FIND_RESTAURANT,
                                userRestaurant.getRestaurant().getName())));

        final var entityToDelete = userRestaurantDao.findByAppUserIsAndRestaurantIs(appUser, restaurantEntity).orElseThrow(() ->
                new IllegalArgumentException("The user %s does not have the restaurant %s saved"
                        .formatted(appUser.getUsername(), restaurantEntity.getName())));

        userRestaurantDao.delete(entityToDelete);
    }

}
