package liberty.capstone.database.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {

    private final CouponEntityDao couponDao;

    @Override
    public Coupon findCouponById(final Long couponId) {
        return couponDao.findById(couponId)
                .orElseThrow(() -> new IllegalArgumentException("Could not find a coupon with Id: " + couponId))
                .toDomainObject();
    }

    @Override
    public List<Coupon> findAllCoupons() {
        return couponDao.findAllByCurrentlyActive(LocalDate.now().toString())
                .stream()
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public List<Coupon> findAllCouponsBySearchTermAndZipCode(final String searchTerm, final String zipCode) {
        log.info("Getting all coupons by search term : {} and zipCode : {}", searchTerm, zipCode);
        return couponDao.findAllByTermZipCodeOrEndDate(searchTerm,
                        getZipcodePrefix(zipCode),
                        LocalDate.now().toString())
                .stream()
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public List<Coupon> getAllCouponsByZipCode(final String zipCode) {
        log.info("Getting all coupons by zipCode : {}", zipCode);
        return couponDao.findAllByZipCodeOrEndDate(getZipcodePrefix(zipCode),
                        LocalDate.now().toString())
                .stream()
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    private String getZipcodePrefix(final String zipCode) {
        final var prefix = zipCode.substring(0, zipCode.length() - 1);
        log.info("Searching by prefix {}", prefix);
        return prefix;
    }
}
