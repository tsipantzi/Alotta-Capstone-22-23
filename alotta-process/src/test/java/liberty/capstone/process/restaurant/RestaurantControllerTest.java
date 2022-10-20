package liberty.capstone.process.restaurant;

import liberty.capstone.core.restaurant.Restaurant;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RestaurantControllerTest {
    @Autowired
    private RestaurantController restaurantController;

    @Test
    void restaurantControllerCanSave() {
        final var restaurant = new Restaurant();
        restaurant.setName("Restaurant Name");
        restaurant.setPhoneNumber("+1-1234567891");
        restaurant.setAboutMe("This is a test about me");
        restaurant.setFoodCategories("FoodCategory1,FoodCategory2");
        restaurant.setEmail("testEmail@gmail.com");
        restaurant.setZipCode("12345");

        final var result = restaurantController.saveRestaurant(restaurant);
        assertAll(() -> {
            assertEquals(restaurant.getName(), result.getName());
            assertEquals(restaurant.getPhoneNumber(), result.getPhoneNumber());
            assertEquals(restaurant.getAboutMe(), result.getAboutMe());
            assertEquals(restaurant.getFoodCategories(), result.getFoodCategories());
            assertEquals(restaurant.getEmail(), result.getEmail());
            assertEquals(restaurant.getZipCode(), result.getZipCode());
        });
    }
}