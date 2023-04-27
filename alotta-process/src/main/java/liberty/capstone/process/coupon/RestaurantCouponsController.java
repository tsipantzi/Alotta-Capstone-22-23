package liberty.capstone.process.coupon;


import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant/{restaurantId}/coupons")
public class RestaurantCouponsController {
    private final RestaurantInventoryService inventoryService;

    @GetMapping
    public List<Coupon> getAllCouponsForRestaurant(@PathVariable final Long restaurantId) {
        final var coupons = inventoryService.findAllCouponsByRestaurantId(restaurantId);
        log.info("Found Coupons {}", coupons);
        return coupons;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable final Long restaurantId,
                             @RequestBody final Coupon coupon) {
        final var saveCoupon = inventoryService.saveCoupon(restaurantId, coupon);
        log.info("Saved Coupon into the database as : {}", saveCoupon);
        return saveCoupon;
    }

    @DeleteMapping
    public ResponseEntity deleteCoupon(@PathVariable final Long restaurantId,
                                       @RequestBody final Coupon coupon) {
        inventoryService.deleteCoupon(restaurantId, coupon);
        return ResponseEntity.ok().build();
    }
}
