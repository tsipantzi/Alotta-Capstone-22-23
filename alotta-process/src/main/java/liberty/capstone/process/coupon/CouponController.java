package liberty.capstone.process.coupon;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant/{restaurantId}/coupon")

public class CouponController {
    private final CouponService couponService;

    @GetMapping
    public List<Coupon> getAllCouponsForRestaurant(@PathVariable final Long restaurantId) {
        final var coupons = couponService.getAllCouponsForRestaurant(restaurantId);
        log.info("Found Coupons {}", coupons);
        return coupons;
    }

    @GetMapping("/{couponId}")
    public Coupon getCouponForRestaurant(@PathVariable final Long restaurantId, @RequestParam final Long couponId) {
        final var coupon = couponService.getCouponForRestaurant(couponId);
        log.info("Found Coupon {}", coupon);
        return coupon;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable final Long restaurantId,
            @RequestBody final Coupon coupon) {
        final var saveCoupon = couponService.saveCoupon(restaurantId, coupon, LocalDate.now(), LocalDate.now());
        log.info("Saved Coupon into the database as : {}", coupon);
        return saveCoupon;
    }

}
