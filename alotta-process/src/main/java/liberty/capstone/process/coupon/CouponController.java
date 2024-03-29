package liberty.capstone.process.coupon;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/coupons")
public class CouponController {
    private final CouponService couponService;

    @GetMapping
    public List<Coupon> getAllCoupons() {
        final List<Coupon> coupons = couponService.findAllCoupons();
        log.info(allCouponsInfoString(coupons.size()));
        return coupons;
    }

    @GetMapping("/{id}")
    public Coupon getCouponById(@PathVariable final Long id) {
        final Coupon coupon = couponService.findCouponById(id);
        log.info(couponByIdString(coupon));
        return coupon;
    }

    @PostMapping("/search")
    public List<Coupon> getAllCouponsBySearchTerm(@RequestBody final AppUser user,
                                                  @RequestParam(required = false) final String searchTerm) {
        final List<Coupon> coupons = searchTerm != null
                ? couponService.findAllCouponsBySearchTermAndZipCode(searchTerm, user)
                : couponService.getAllCouponsByZipCode(user);
        log.info(searchTermInfoString(coupons.size(), searchTerm));
        return coupons;
    }

    private static String couponByIdString(final Coupon coupon) {
        return String.format("Got Coupon: %s by Id", coupon);
    }

    private static String allCouponsInfoString(final int numberOfCoupons) {
        return String.format("Got %s results for coupons. Sending it to the front end", numberOfCoupons);
    }

    private static String searchTermInfoString(final int numberOfCoupons, final String searchTerm) {
        return String.format("Got %s results for coupons by searchTerm: %s. Sending it to the front end",
                numberOfCoupons, searchTerm);
    }
}
