package liberty.capstone.example;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/rest/coupon") //is this line right?
public class CouponController {
    private final CouponService couponService;

    @GetMapping
    public List<Coupon> getCouponsByCouponType(@RequestParam final String couponType) {
        final var couponRecieved = couponService.findExamplesByCouponType(couponType); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("couponType") final String couponType) {
        final var couponSaved = couponService.save(couponType);
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByPercentageOff(@RequestParam final Long percentageOff) {
        final var couponRecieved = couponService.findExamplesByPercentageOff(percentageOff); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("percentageOff") final Long percentageOff) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }


    @GetMapping
    public List<Coupon> getCouponsByDollarsOff(@RequestParam final Long dollarsOff) {
        final var couponRecieved = couponService.findExamplesByDollarsOff(dollarsOff); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("dollarsOff") final Long dollarsOff) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByCouponInfo(@RequestParam final String couponInfo) {
        final var couponRecieved = couponService.findExamplesByDollarsOff(couponInfo); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("couponInfo") final String couponInfo) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByFoodCategories(@RequestParam final String foodCategories) {
        final var couponRecieved = couponService.findExamplesByFoodCategories(foodCategories); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("foodCategories") final String foodCategories) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByNumberOfCouponsPerCustomer(@RequestParam final Long numberOfCouponsPerCustomer) {
        final var couponRecieved = couponService.findExamplesByNumberOfCouponsPerCustomer(numberOfCouponsPerCustomer); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("numberOfCouponsPerCustomer") final Long numberOfCouponsPerCustomer) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByTotalNumberOfCoupons(@RequestParam final Long totalNumberOfCoupons) {
        final var couponRecieved = couponService.findExamplesByNumberOfCouponsPerCustomer(numberOfCouponsPerCustomer); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("totalNumberOfCoupons") final Long totalNumberOfCoupons) {
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @GetMapping
    public List<Coupon> getCouponsByNumberOfCouponsSold(@RequestParam final Long numberOfCouponsSold) {
        final var couponRecieved = CouponService.findExamplesByNumberOfCouponsSold(numberOfCouponsSold); //coupons revieved ot should it be object recieved
        log.warn("Got object from database as : {}", couponRecieved);
        return couponRecieved;
    }

    @PostMapping
    public Coupon saveCoupon(@PathVariable("numberOfCouponsSold") final Long numberOfCouponsSold) {
        final var couponSaved = CouponService.save(numberOfCouponsSold);
        log.warn("Saved object into database as : {}", couponSaved);
        return couponSaved;
    }

    @PostMapping
    public Coupon saveCoupon(@RequestBody final Coupon coupon){
        couponService.save(Coupon coupon)
    };
}
