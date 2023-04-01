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
@RequestMapping("/userId")
public class CustomerInventoryController {
    private final CustomerInventoryService customerInventoryService;
    @PostMapping("/{id}/coupons/save")
    public Coupon saveCouponForCustomer(@PathVariable final String id,
                                        @RequestParam final String couponId) {
        return customerInventoryService.saveCouponForCustomer(Long.parseLong(id), Long.parseLong(couponId))
                .getCoupon();
    }

    @GetMapping("/{id}/coupons")
    public List<Coupon> getAllClaimedCouponsForCustomer(@PathVariable final String id) {
        return customerInventoryService.findAllByUserIs(Long.parseLong(id));
    }
}
