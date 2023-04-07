package liberty.capstone.database.customerinventory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.customerinventory.CustomerInventory;
import liberty.capstone.core.customerinventory.CustomerInventoryService;
import liberty.capstone.database.appuser.AppUserDao;
import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.coupon.CouponEntityDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class CustomerInventoryServiceImpl implements CustomerInventoryService {
    public static final String USER_DOES_NOT_EXIST = "User %s does not exist";
    public static final String COUPON_DOES_NOT_EXIST = "Coupon %s does not exist";
    public static final String CUSTOMER_INVENTORY_DOES_NOT_EXIST = "Customer %s has not claimed Coupon %s";
    private final CustomerInventoryEntityDao customerInventoryDao;
    private final CouponEntityDao couponDao;
    private final AppUserDao appUserDao;

    @Override
    @Transactional
    public List<Coupon> findAllByUserIs(final Long userId) {
        getUserOrThrow(userId);
        
        return customerInventoryDao.findAllByCustomer_Id(userId)
                .stream()
                .map(CustomerInventoryEntity::toDomainObject)
                .map(CustomerInventory::getCoupon)
                .collect(Collectors.toList());
    }

    @Override
    public CustomerInventory saveCouponForCustomer(final Long userId,
                                                   final Long couponId) {
        final var user = getUserOrThrow(userId);

        final var foundCoupon = getCouponOrThrow(couponId);

        return customerInventoryDao.saveAndFlush(new CustomerInventoryEntity(foundCoupon, user))
                .toDomainObject();
    }

    @Override
    public boolean redeemCoupon(final Long userId,
                                final Long couponId) {
        getUserOrThrow(userId);
        getCouponOrThrow(couponId);

        final var foundCustomerInventory = getCustomerInventoryOrThrow(userId, couponId);


        if (foundCustomerInventory.isRedeemed()) {
            log.warn(String.format("Customer %s has already redeemed coupon %s", userId, couponId));
            return false;
        } else {
            foundCustomerInventory.setRedeemed(true);
            customerInventoryDao.saveAndFlush(foundCustomerInventory);
            log.info(String.format("Customer %s has redeemed coupon %s", userId, couponId));
            return true;
        }
    }

    private CustomerInventoryEntity getCustomerInventoryOrThrow(final Long userId, final Long couponId) {
        return customerInventoryDao.findAllByCustomer_IdAndCoupon_Id(userId, couponId)
                .stream()
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(
                        String.format(CUSTOMER_INVENTORY_DOES_NOT_EXIST, userId, couponId)));
    }

    private CouponEntity getCouponOrThrow(final Long couponId) {
        return couponDao.findById(couponId)
                .orElseThrow(() -> new IllegalArgumentException(
                        String.format(COUPON_DOES_NOT_EXIST, couponId)));
    }

    private AppUserEntity getUserOrThrow(final Long userId) {
        return appUserDao.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException(
                        String.format(USER_DOES_NOT_EXIST, userId)));
    }

}
