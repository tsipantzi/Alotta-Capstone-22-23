package liberty.capstone.database.customerinventory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.customerinventory.CustomerInventory;
import liberty.capstone.core.customerinventory.CustomerInventoryService;
import liberty.capstone.database.appuser.AppUserDao;
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
    private final CustomerInventoryEntityDao customerInventoryDao;
    private final CouponEntityDao couponDao;
    private final AppUserDao appUserDao;

    @Override
    @Transactional
    public List<Coupon> findAllByUserIs(final Long userId) {
        appUserDao.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Customer does not exist"));
        
        return customerInventoryDao.findAllByCustomer_Id(userId)
                .stream()
                .map(CustomerInventoryEntity::toDomainObject)
                .map(CustomerInventory::getCoupon)
                .collect(Collectors.toList());
    }

    @Override
    public CustomerInventory saveCouponForCustomer(final Long userId,
                                                   final Long couponId) {
        final var user = appUserDao.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException(
                        String.format("app user %s does not exist ", userId)));

        final var foundCoupon = couponDao.findById(couponId)
                .orElseThrow(() -> new IllegalArgumentException(
                        String.format("Coupon %s does not exist", couponId)));

        return customerInventoryDao.saveAndFlush(new CustomerInventoryEntity(foundCoupon, user))
                .toDomainObject();
    }

}
