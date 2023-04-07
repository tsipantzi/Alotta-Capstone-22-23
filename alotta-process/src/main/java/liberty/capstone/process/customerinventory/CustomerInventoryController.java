package liberty.capstone.process.customerinventory;

import java.util.List;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.customerinventory.CustomerInventoryService;
import lombok.RequiredArgsConstructor;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/userId/{id}/coupons")
public class CustomerInventoryController {
    private final CustomerInventoryService customerInventoryService;

    @GetMapping
    public List<Coupon> getAllClaimedCouponsForCustomer(@PathVariable final String id) {
        return customerInventoryService.findAllByUserIs(Long.parseLong(id));
    }

    @PostMapping("/{couponId}/save")
    public Coupon saveCouponForCustomer(@PathVariable final String id,
                                        @PathVariable final String couponId) {
        return customerInventoryService.saveCouponForCustomer(Long.parseLong(id), Long.parseLong(couponId))
                .getCoupon();
    }

    @PostMapping("/{couponId}/redeem")
    public boolean redeemCoupon(@PathVariable final String id,
                                @PathVariable final String couponId) {
        return customerInventoryService.redeemCoupon(Long.parseLong(id), Long.parseLong(couponId));
    }
}
