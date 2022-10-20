package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.coupon.CouponEntityDao;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@Slf4j
@DataJpaTest
@Sql(scripts = "/restaurant-inventory-setup.sql")
class RestaurantInventoryEntityDaoTest {
    @Autowired
    RestaurantInventoryEntityDao inventoryEntityDao;
    @Autowired
    RestaurantEntityDao restaurantDao;
    @Autowired
    CouponEntityDao couponDao;

    @Test
    void canSaveInventoryEntity() {
        final var restaurant = new RestaurantEntity();
        restaurant.setName("New Restaurant Name");
        restaurant.setPhoneNumber("+1-1234567891");
        final var coupon = new CouponEntity();
        coupon.setCouponInfo("This is the coupon info");
        final var savedRestaurant = restaurantDao.save(restaurant);
        final var savedCoupon = couponDao.save(coupon);

        final var restaurantInventory = new RestaurantInventoryEntity();
        restaurantInventory.setRestaurant(savedRestaurant);
        restaurantInventory.setCoupon(savedCoupon);
        inventoryEntityDao.save(restaurantInventory);

        final var result = inventoryEntityDao.findAll().get(0);
        assertAll(() -> {
            assertEquals(savedRestaurant.getId(), result.getRestaurant().getId());
            assertEquals(savedRestaurant.getName(), result.getRestaurant().getName());
            assertEquals(savedRestaurant.getPhoneNumber(), result.getRestaurant().getPhoneNumber());

            assertEquals(savedCoupon.getId(), result.getCoupon().getId());
            assertEquals(savedCoupon.getCouponInfo(), result.getCoupon().getCouponInfo());
        });

        log.info("Successfully created RestaurantInventory item : {}", String.valueOf(result));
    }
}