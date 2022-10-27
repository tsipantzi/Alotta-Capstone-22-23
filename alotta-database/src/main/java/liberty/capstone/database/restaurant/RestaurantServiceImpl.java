package liberty.capstone.database.restaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RestaurantServiceImpl implements RestaurantService {
    private final RestaurantEntityDao restaurantDao;
    @Override
    public List<Restaurant> findRestaurantsByName(final String name) {
        return restaurantDao.findAllByName(name)
                .stream()
                .map(this::toRestaurantObject)
                .collect(Collectors.toList());
    }

    @Override
    public Restaurant saveRestaurant(final Restaurant restaurant) {
        final var entityToSave = toRestaurantEntity(restaurant);
        return toRestaurantObject(restaurantDao.save(entityToSave));
    }

    private Restaurant toRestaurantObject(final RestaurantEntity entity) {
        final var restaurant = new Restaurant();
        restaurant.setId(entity.getId());
        restaurant.setName(entity.getName());
        restaurant.setPhoneNumber(entity.getPhoneNumber());
        restaurant.setAboutMe(entity.getAboutMe());
        restaurant.setFoodCategories(entity.getFoodCategories());
        restaurant.setEmail(entity.getEmail());
        restaurant.setMaxCateringSizePerPerson(entity.getMaxCateringSizePerPerson());
        restaurant.setMinimumNotice(entity.getMinimumNotice());
        restaurant.setZipCode(entity.getZipCode());
        return restaurant;
    }

    private RestaurantEntity toRestaurantEntity(final Restaurant object) {
        final var entity = new RestaurantEntity();
        entity.setId(object.getId());
        entity.setName(object.getName());
        entity.setPhoneNumber(object.getPhoneNumber());
        entity.setAboutMe(object.getAboutMe());
        entity.setFoodCategories(object.getFoodCategories());
        entity.setEmail(object.getEmail());
        entity.setMaxCateringSizePerPerson(object.getMaxCateringSizePerPerson());
        entity.setMinimumNotice(object.getMinimumNotice());
        entity.setZipCode(object.getZipCode());
        return entity;
    }
}
