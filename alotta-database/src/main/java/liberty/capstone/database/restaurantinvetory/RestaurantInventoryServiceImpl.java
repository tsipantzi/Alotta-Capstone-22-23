package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RestaurantInventoryServiceImpl implements RestaurantInventoryService {
    private final RestaurantEntityDao restaurantDao;
    private final RestaurantInventoryEntityDao restaurantInventoryDao;
    @Override
    public List<RestaurantInventory> getRestaurantInventoryById(final Long id) {
        final var restaurant = restaurantDao.findById(id).orElseThrow();
        return restaurantInventoryDao.findAllByRestaurantIs(restaurant).stream()
                .map(this::toRestaurantInventoryObject)
                .collect(Collectors.toList());
    }

    @Override
    public RestaurantInventory saveInventoryItem(final Long id, final RestaurantInventory item) {
        final var restaurant = restaurantDao.findById(id).orElseThrow();
        final var restaurantInventoryEntityToSave = new RestaurantInventoryEntity();
        restaurantInventoryEntityToSave.setRestaurant(restaurant);
        restaurantInventoryEntityToSave.setStartDate(item.getStartDate());
        restaurantInventoryEntityToSave.setEndDate(item.getEndDate());
        return toRestaurantInventoryObject(restaurantInventoryDao.save(restaurantInventoryEntityToSave));
    }

    private RestaurantInventory toRestaurantInventoryObject(final RestaurantInventoryEntity entity) {
        final var restaurantInventory = new RestaurantInventory();
        restaurantInventory.setRestaurant(toRestaurantObject(entity.getRestaurant()));
        restaurantInventory.setStartDate(entity.getStartDate());
        restaurantInventory.setEndDate(entity.getEndDate());
        return restaurantInventory;
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
}
