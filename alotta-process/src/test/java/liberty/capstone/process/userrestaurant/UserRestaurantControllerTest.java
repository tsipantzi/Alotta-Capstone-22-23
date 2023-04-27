package liberty.capstone.process.userrestaurant;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.userrestaurant.UserRestaurant;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class UserRestaurantControllerTest {
    @Autowired
    private UserRestaurantController instance;
    @Autowired
    private AppUserService appUserService;

    private AppUser savedUser;
    private Restaurant savedRestaurant;

    @Test
    void getAllRestaurants_CanFindAllRestaurants_byUserId() {
        final var user = new AppUser();
        user.setZipcode("12345");
        user.setUsername("Test User1");
        user.setPassword("Test Password");

        savedUser = appUserService.createAppUser(user);

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");
        restaurant.setZipCode("12346");

        savedRestaurant = instance.saveRestaurantForUser(new UserRestaurant(savedUser, restaurant)).getRestaurant();

        final var results = instance.getAllRestaurants(savedUser.getId(), null);
        assertEquals(1, results.size());
        final var result = results.get(0);

        assertAll(
                () -> assertEquals(savedRestaurant.getId(), result.getId()),
                () -> assertEquals(savedRestaurant.getName(), result.getName()),
                () -> assertEquals(savedRestaurant.getZipCode(), result.getZipCode()));
    }

    @Test
    void getAllRestaurants_CanFindAllRestaurants_byZipCode() {
        final var user = new AppUser();
        user.setZipcode("12345");
        user.setUsername("Test User2");
        user.setPassword("Test Password");

        savedUser = appUserService.createAppUser(user);

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");
        restaurant.setZipCode("12346");

        savedRestaurant = instance.saveRestaurantForUser(new UserRestaurant(savedUser, restaurant)).getRestaurant();

        final var results = instance.getAllRestaurants(null, "12345");
        assertEquals(1, results.size());
        final var result = results.get(0);

        assertAll(
                () -> assertEquals(savedRestaurant.getId(), result.getId()),
                () -> assertEquals(savedRestaurant.getName(),result.getName()),
                () -> assertEquals(savedRestaurant.getZipCode(), result.getZipCode()));
    }

    @Test
    void deleteRestaurantForUser_CanDeleteRestaurant() {
        final var user = new AppUser();
        user.setZipcode("12345");
        user.setUsername("Test User3");
        user.setPassword("Test Password");

        savedUser = appUserService.createAppUser(user);

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");
        restaurant.setZipCode("12346");

        savedRestaurant = instance.saveRestaurantForUser(new UserRestaurant(savedUser, restaurant)).getRestaurant();

        instance.deleteRestaurantForUser(new UserRestaurant(savedUser, savedRestaurant));

        final var results = instance.getAllRestaurants(savedUser.getId(), null);
        assertEquals(0, results.size());
    }
}