package liberty.capstone.database.restaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class RestaurantServiceImpl implements RestaurantService {
    private final RestaurantEntityDao restaurantDao;
    @Override
    public List<Restaurant> findRestaurantsByName(final String name) {
        return restaurantDao.findAllByName(name)
                .stream()
                .map(RestaurantEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public Restaurant saveRestaurant(final Restaurant restaurant) {
        final var entityToSave = new RestaurantEntity(restaurant);
        final var savedRestaurant = restaurantDao.saveAndFlush(entityToSave);
        log.info("Saved Restaurant to the database {}", savedRestaurant);
        return savedRestaurant.toDomainObject();
    }
}
