package liberty.capstone.process.customerinventory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.customerinventory.CustomerInventoryService;
import liberty.capstone.process.qr.QRCodeBuilderService;
import liberty.capstone.process.qr.QRCodeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/userId/{id}/coupons")
public class CustomerInventoryController {
    private final CustomerInventoryService customerInventoryService;
    private final QRCodeBuilderService qrCodeBuilderService;
    private final QRCodeService qrCodeService;

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

    @GetMapping(value = "/{couponId}/qr", produces = MediaType.IMAGE_PNG_VALUE)
    public @ResponseBody byte[] getQRCode(@PathVariable final String id,
                          @PathVariable final String couponId) {
        final String url = qrCodeBuilderService.buildRedeemUrl(id, couponId);
        return qrCodeService.getQRCode(url);
    }
}
