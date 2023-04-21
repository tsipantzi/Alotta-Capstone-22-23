package liberty.capstone.database.coupon;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import liberty.capstone.database.customerinventory.CustomerInventoryEntity;
import liberty.capstone.database.customerinventory.CustomerInventoryEntityDao;
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
    private final CustomerInventoryEntityDao customerInventoryDao;

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
    public List<Coupon> findAllCouponsBySearchTermAndZipCode(final String searchTerm, final AppUser user) {
        final var usersCurrentCouponIds = getCouponIdsForUser(user.getId());

        log.info("Getting all coupons by search term : {} for user : {}", searchTerm, user.getUsername());
        return couponDao.findAllByTermZipCodeOrEndDate(searchTerm,
                        getZipcodePrefix(user.getZipcode()),
                        LocalDate.now().toString())
                .stream()
                .filter(coupon -> usersCurrentCouponIds.isEmpty()
                        || !usersCurrentCouponIds.contains(coupon.getId()))
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public List<Coupon> getAllCouponsByZipCode(final AppUser user) {
        final var usersCurrentCouponIds = getCouponIdsForUser(user.getId());

        log.info("Getting all coupons for user : {}", user.getUsername());
        return couponDao.findAllByZipCodeOrEndDate(getZipcodePrefix(user.getZipcode()),
                        LocalDate.now().toString())
                .stream()
                .filter(coupon -> usersCurrentCouponIds.isEmpty()
                        || !usersCurrentCouponIds.contains(coupon.getId()))
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    private List<Long> getCouponIdsForUser(final Long userId) {
        return customerInventoryDao.findAllByCustomer_Id(userId)
                .stream()
                .map(CustomerInventoryEntity::getCoupon)
                .map(CouponEntity::getId)
                .toList();
    }

    private String getZipcodePrefix(final String zipCode) {
        final var prefix = zipCode.substring(0, zipCode.length() - 1);
        log.info("Searching by prefix {}", prefix);
        return prefix;
    }
}
