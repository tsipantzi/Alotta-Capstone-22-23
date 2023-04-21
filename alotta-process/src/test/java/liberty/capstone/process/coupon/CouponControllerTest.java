package liberty.capstone.process.coupon;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CouponControllerTest {
    static final LocalDate TODAY = LocalDate.now();
    @Autowired
    CouponController instance;
    @Autowired
    RestaurantInventoryService inventoryService;
    @Autowired
    RestaurantService restaurantService;

    Coupon savedCouponOne;
    Coupon savedCouponTwo;
    Restaurant savedRestaurantOne;
    Restaurant savedRestaurantTwo;

    @BeforeEach
    void setUp() {
        final var couponOne = new Coupon();
        couponOne.setTitle("Coupon Title One");
        couponOne.setStartDate(TODAY.minusDays(3));
        couponOne.setEndDate(TODAY.plusDays(3));
        final var couponTwo = new Coupon();
        couponTwo.setTitle("Coupon Title Two");
        couponTwo.setStartDate(TODAY.minusDays(3));
        couponTwo.setEndDate(TODAY.plusDays(3));

        final var restaurantOne = new Restaurant();
        restaurantOne.setName("Restaurant One");
        restaurantOne.setZipCode("123456");
        final var restaurantTwo = new Restaurant();
        restaurantTwo.setName("Restaurant One");
        restaurantTwo.setZipCode("123457");

        savedRestaurantOne = restaurantService.saveRestaurant(restaurantOne);
        savedRestaurantTwo = restaurantService.saveRestaurant(restaurantTwo);


        savedCouponOne = inventoryService.saveCoupon(savedRestaurantOne.getId(), couponOne);
        savedCouponTwo = inventoryService.saveCoupon(savedRestaurantTwo.getId(), couponTwo);
    }

    @Test
    void getAllCoupons() {
        final var results = instance.getAllCoupons();

        assertAll(
                () -> assertTrue(results.contains(savedCouponOne)),
                () -> assertTrue(results.contains(savedCouponTwo)));
    }

    @Test
    void getCouponById() {
        final var resultOne = instance.getCouponById(savedCouponOne.getId());
        final var resultTwo = instance.getCouponById(savedCouponTwo.getId());

        assertAll(() -> assertEquals(savedCouponOne, resultOne),
                () -> assertEquals(savedCouponTwo, resultTwo));
    }
    @Test
    void getAllCouponsBySearchTerm_SearchByCoupon() {
        final var appUser = new AppUser();
        appUser.setZipcode("123455");

        final var results = instance.getAllCouponsBySearchTerm(appUser, "Coupon");

        assertTrue(results.contains(savedCouponOne));
        assertTrue(results.contains(savedCouponTwo));
    }

    @Test
    void getAllCouponsBySearchTerm_SearchByCouponOne() {
        final var appUser = new AppUser();
        appUser.setZipcode("123455");

        final var results = instance.getAllCouponsBySearchTerm(appUser, "Coupon Title One");
        final var expectedResults = List.of(savedCouponOne);

        assertEquals(expectedResults, results);
        assertFalse(results.contains(savedCouponTwo));
    }
}