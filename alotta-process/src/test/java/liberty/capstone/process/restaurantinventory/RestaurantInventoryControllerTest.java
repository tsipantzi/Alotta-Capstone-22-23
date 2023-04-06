package liberty.capstone.process.restaurantinventory;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

@SpringBootTest
class RestaurantInventoryControllerTest {
    @Autowired
    private RestaurantInventoryController restaurantInventoryController;
    @Autowired
    private RestaurantService restaurantService;

    @Test
    void restaurantInventoryControllerCanSave() {
        final var restaurant = new Restaurant();
        restaurant.setName("Restaurant Name");
        restaurant.setPhoneNumber("+1-1234567891");
        restaurant.setAboutMe("This is a test about me");
        restaurant.setFoodCategories("FoodCategory1,FoodCategory2");
        restaurant.setEmail("testEmail@gmail.com");
        restaurant.setZipCode("12345");

        final var savedRestaurant = restaurantService.saveRestaurant(restaurant);

        final var restaurantInventory = new RestaurantInventory();
        restaurantInventory.setRestaurant(restaurant);
        restaurantInventory.setStartDate(LocalDate.now());
        restaurantInventory.setEndDate(LocalDate.now());

/*        final var result = restaurantInventoryController.saveRestaurantInventoryItem(savedRestaurant.getId(), restaurantInventory);

        assertAll(() -> {
            assertEquals(savedRestaurant.getId(), result.getRestaurant().getId());
            assertEquals(restaurant.getName(), result.getRestaurant().getName());
            assertEquals(restaurant.getPhoneNumber(), result.getRestaurant().getPhoneNumber());
            assertEquals(restaurant.getAboutMe(), result.getRestaurant().getAboutMe());
            assertEquals(restaurant.getFoodCategories(), result.getRestaurant().getFoodCategories());
            assertEquals(restaurant.getEmail(), result.getRestaurant().getEmail());
            assertEquals(restaurant.getZipCode(), result.getRestaurant().getZipCode());
        });*/
    }
}