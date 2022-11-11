package liberty.capstone.process.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant/{restaurantId}/coupon")

public class CouponController {
    private final CouponService couponService;
    private final RestaurantInventoryService inventoryService;

    @GetMapping
    public List<Coupon> getAllCouponsForRestaurant(@PathVariable final Long restaurantId) {
        final var coupons = couponService.getAllCouponsForRestaurant(restaurantId);
        log.info("Found Coupons {}", coupons);
        return coupons;
    }

    @GetMapping("/{couponId}")
    public RestaurantInventory getCouponForRestaurant(@PathVariable final Long restaurantId,
                                                      @PathVariable final Long couponId) {
        final var inventoryItem = inventoryService.getRestaurantInventoryById(restaurantId)
                .stream()
                .filter(Objects::nonNull)
                .filter(item -> item.getCoupon() != null && couponId.equals(item.getCoupon().getId()))
                .findFirst()
                .orElse(new RestaurantInventory());
        log.info("Found Restaurant Inventory Item {}", inventoryItem);
        return inventoryItem;
    }

    @PostMapping
    public RestaurantInventory saveCoupon(@PathVariable final Long restaurantId,
            @RequestBody final Coupon coupon) {
        final var saveCoupon = couponService.saveCoupon(restaurantId, coupon);
        log.info("Saved Coupon into the database as : {}", coupon);
        return saveCoupon;
    }

}
