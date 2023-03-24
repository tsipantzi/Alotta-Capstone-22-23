package liberty.capstone.database.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponSearchOptions;
import liberty.capstone.core.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
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
    public List<Coupon> findAllCouponsBySearchTerm(final String searchTerm) {
        return couponDao.findAllByTerm(searchTerm, LocalDate.now().toString())
                .stream()
                .map(CouponEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public List<Coupon> getAllCouponsByOptions(final CouponSearchOptions options) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getAllCouponsByOptions'");
    }
}
