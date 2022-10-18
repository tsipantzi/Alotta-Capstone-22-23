package liberty.capstone.Coupon;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public final class CouponServices implements Service {
    private final CouponDao couponDao;

    public CouponServices(final CouponDao couponDao) {
        this.couponDao = couponDao;
    }

    @Override
    public List<Coupon> findExamplesByType(final String name) {
        return couponDao.findAll()
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toExampleObject)
                .toList();
    }

    @Override
    public Coupon save(final String type) {
        final var newEntity = new Coupon();
        newEntity.setCouponType(type);
        return toExampleObject(couponDao.save(newEntity));
    }

    private Coupon toExampleObject(final Coupon entity) {
        final var newExampleObject = new Coupon();
        newExampleObject.setName(entity.getName());
        return newExampleObject;
    }
}
