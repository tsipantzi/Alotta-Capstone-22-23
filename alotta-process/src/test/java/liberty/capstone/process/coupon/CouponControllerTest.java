package liberty.capstone.process.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(properties = {"spring.jpa.properties.hibernate.enable_lazy_load_no_trans=true"})
class CouponControllerTest {
    @Autowired
    private CouponController instance;
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
        final var savedCouponOne = instance.saveCoupon(savedRestaurantId, couponOne).getCoupon();
        final var savedCouponTwo = instance.saveCoupon(savedRestaurantId, couponTwo).getCoupon();

        final var results = instance.getAllCouponsForRestaurant(savedRestaurantId);
        final var restaurantInventoryResult = instance.getCouponForRestaurant(savedRestaurantId,
                savedCouponOne.getId());
        assertAll(
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponOne.getId().equals(coupon.getId()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponTwo.getId().equals(coupon.getId()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponOne.getStartDate().equals(coupon.getStartDate()))),
                () -> assertTrue(results.stream().anyMatch(coupon -> savedCouponTwo.getStartDate().equals(coupon.getStartDate()))),
                () -> assertTrue(results.stream().allMatch(coupon -> "Test Title".equals(coupon.getTitle()))),
                () -> assertEquals(savedRestaurantId, restaurantInventoryResult.getRestaurant().getId()),
                () -> assertEquals(savedCouponOne.getId(), restaurantInventoryResult.getCoupon().getId())
        );
    }
}