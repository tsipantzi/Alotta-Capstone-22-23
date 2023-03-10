package liberty.capstone.process.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CouponControllerTest {
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
        final var couponTwo = new Coupon();
        couponTwo.setTitle("Coupon Title Two");

        final var restaurantOne = new Restaurant();
        restaurantOne.setName("Restaurant One");
        final var restaurantTwo = new Restaurant();
        restaurantTwo.setName("Restaurant One");

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

        final var results = instance.getAllCouponsBySearchTerm("Coupon");

        assertTrue(results.contains(savedCouponOne));
        assertTrue(results.contains(savedCouponTwo));
    }

    @Test
    void getAllCouponsBySearchTerm_SearchByCouponOne() {

        final var results = instance.getAllCouponsBySearchTerm("Coupon Title One");
        final var expectedResults = List.of(savedCouponOne);

        assertEquals(expectedResults, results);
        assertFalse(results.contains(savedCouponTwo));
    }
}