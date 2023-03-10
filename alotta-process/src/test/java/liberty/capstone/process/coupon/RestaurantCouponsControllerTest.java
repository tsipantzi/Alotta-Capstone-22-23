package liberty.capstone.process.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RestaurantCouponsControllerTest {
    @Autowired
    private RestaurantCouponsController instance;
    @Autowired
    private RestaurantService restaurantService;

    @Test
    void getAllCouponsForRestaurant_CanFindAllCoupons() {
        final var couponOne = new Coupon();
        couponOne.setTitle("Test Title");
        couponOne.setStartDate(LocalDate.now());

        final var couponTwo = new Coupon();
        couponTwo.setTitle("Test Title");
        couponTwo.setStartDate(LocalDate.now());

        final var restaurant = new Restaurant();
        restaurant.setName("Test Restaurant");

        final var savedRestaurantId = restaurantService.saveRestaurant(restaurant).getId();
        final var savedCouponOne = instance.saveCoupon(savedRestaurantId, couponOne);
        final var savedCouponTwo = instance.saveCoupon(savedRestaurantId, couponTwo);

        final var results = instance.getAllCouponsForRestaurant(savedRestaurantId);
        assertAll(
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponOne.getId().equals(coupon.getId()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponTwo.getId().equals(coupon.getId()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponOne.getStartDate().equals(coupon.getStartDate()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponTwo.getStartDate().equals(coupon.getStartDate()))),
                () -> assertTrue(results.stream().allMatch(coupon -> "Test Title".equals(coupon.getTitle())))
        );
    }
}