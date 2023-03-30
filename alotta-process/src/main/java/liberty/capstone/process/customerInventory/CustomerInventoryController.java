package liberty.capstone.process.customerInventory;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.customerinventory.CustomerInventoryService;
import lombok.RequiredArgsConstructor;
 
@RequiredArgsConstructor
@RequestMapping("/userId/{id}/coupons")
public class CustomerInventoryController{
    private final CustomerInventoryService customerInventoryService;
    @PostMapping("/save")
    public Coupon saveCouponForCustomer(@PathVariable final Long id,
                                        @RequestParam final Long couponId) {
        return customerInventoryService.saveCouponForCustomer(id, couponId).getCoupon();
    }

    @GetMapping
    public List<Coupon> getAllClaimedCouponsForCustomer(
        @PathVariable final Long id) {
        return customerInventoryService.findAllByUserIs(id);
    }
}
