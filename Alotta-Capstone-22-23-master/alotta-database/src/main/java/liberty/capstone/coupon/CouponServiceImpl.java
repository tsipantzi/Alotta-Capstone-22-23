package liberty.capstone.database.coupon;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import liberty.capstone.example.CouponDao;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {
    private final CouponDao couponDao;
    @Override
    public List<Coupon> findCouponByType(final String type) {
        return couponDao.findAllByType(type)
                .stream()
                .map(this::toCouponObject)
                .collect(Collectors.toList());
    }

    @Override
    public Coupon saveCoupon(final Coupon coupon) {
        final var entityToSave = toCouponEntity(coupon);
        return toCouponObject(couponDao.save(entityToSave));
    }

    private Coupon toCouponObject(final CouponEntity entity) {
        final var coupon = new Coupon();
        coupon.setId(entity.getId());
        coupon.setType(entity.getCouponType());
        coupon.setPercentageOff(entity.getPercentageOff());
        coupon.setDollarsOff(entity.getDollarsOff());
        coupon.setCouponInfo(entity.getCouponInfo());
        coupon.setFoodCategories(entity.getFoodCategories());
        coupon.setNumberOfCouponsPerCustomer(entity.getNumberOfCouponsPerCustomer());
        coupon.setTotalNumberOfCoupons(entity.getTotalNumberOfCoupons());
        coupon.setNumberOfCouponsSold(entity.getNumberOfCouponsSold());
        return coupon;
    }

    private couponEntity tocouponEntity(final liberty.capstone.example.Coupon object) {
        final var entity = new couponEntity();
        entity.setId(object.getIf());
        entity.setType(object.getCouponType());
        entity.setPercentageOff(object.getPercentageOff());
        entity.setDollarsOff(object.getDollarsOff());
        entity.setCouponInfo(object.getCouponInfo());
        entity.setFoodCategories(object.getFoodCategories());
        entity.setNumberOfCouponsPerCustomer(object.getNumberOfCouponsPerCustomer());
        entity.setTotalNumberOfCoupons(object.getTotalNumberOfCoupons());
        entity.setNumberOfCouponsSold(object.getNumberOfCouponsSold());
        return entity;
    }
}