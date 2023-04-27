package liberty.capstone.process.customerinventory;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;
import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class CustomerInventoryControllerTest {
    @Autowired
    private CustomerInventoryController instance;
    @Autowired
    private AppUserService appUserService;
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private RestaurantInventoryService restaurantInventoryService;

    AppUser savedUser;
    Coupon savedCoupon;

    @Test
    void getAllClaimedCouponsForCustomer() {
        final var user = new AppUser();
        user.setZipcode("12345");
        user.setUsername("Test User1");
        user.setPassword("Test Password");

        savedUser = appUserService.createAppUser(user);

        final var coupon = new Coupon();
        coupon.setTitle("Test Coupon");
        coupon.setStartDate(LocalDate.now().minusDays(1));
        coupon.setEndDate(LocalDate.now().plusDays(1));

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");
        restaurant.setZipCode("12346");

        final var savedRestaurant = restaurantService.saveRestaurant(restaurant);

        savedCoupon = restaurantInventoryService.saveCoupon(savedRestaurant.getId(), coupon);

        instance.saveCouponForCustomer(savedUser.getId().toString(), savedCoupon.getId().toString());

        final var results = instance.getAllClaimedCouponsForCustomer(savedUser.getId().toString());


        assertAll(() -> assertEquals(1, results.size()),
                () -> assertEquals(savedCoupon.getId(), results.get(0).getId()),
                () -> assertEquals(savedCoupon.getTitle(), results.get(0).getTitle()),
                () -> assertEquals(savedCoupon.getStartDate(), results.get(0).getStartDate()),
                () -> assertEquals(savedCoupon.getEndDate(), results.get(0).getEndDate()));
    }

    @Test
    void deleteCouponForCustomer() {
        final var user = new AppUser();
        user.setZipcode("12345");
        user.setUsername("Test User2");
        user.setPassword("Test Password");

        savedUser = appUserService.createAppUser(user);

        final var coupon = new Coupon();
        coupon.setTitle("Test Coupon");
        coupon.setStartDate(LocalDate.now().minusDays(1));
        coupon.setEndDate(LocalDate.now().plusDays(1));

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");
        restaurant.setZipCode("12346");

        final var savedRestaurant = restaurantService.saveRestaurant(restaurant);

        savedCoupon = restaurantInventoryService.saveCoupon(savedRestaurant.getId(), coupon);

        instance.saveCouponForCustomer(savedUser.getId().toString(), savedCoupon.getId().toString());

        instance.deleteCouponForCustomer(savedUser.getId().toString(), savedCoupon.getId().toString());

        final var results = instance.getAllClaimedCouponsForCustomer(savedUser.getId().toString());

        assertEquals(0, results.size());
    }
}