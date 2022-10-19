package liberty.capstone.example;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public final class CouponServicesImpl implements CouponServices {
    private final CouponDao couponDao;

    public CouponServicesImpl(final CouponDa0 couponDao) {
        this.couponDao = couponDao;
    }    

    @Override
    public List<Example> findExamplesByName(final String name) {
        return exampleDao.findAllByName(name)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toExampleObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByCouponType(final String couponType) {
        return couponDao.findAllByCouponType(couponType)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByPercentageOff(final Long percentageOff) {
        return couponDao.findCouponsByPercentageOff(percentageOff)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByDollarsOff(final Long dollarsOff) {
        return couponDao.findCouponsByDollarsOff(dollarsOff)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByCouponInfo(final String couponInfo) {
        return couponDao.findCouponsByCouponInfo(couponInfo)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByFoodCategories(final String foodCategories) {
        return couponDao.findCouponsByFoodCategories(foodCategories)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByNumberOfCouponsPerCustome(final Long numberOfCouponsPerCustomer) {
        return couponDao.findCouponsByNumberOfCouponsPerCustome(numberOfCouponsPerCustomer)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByTotalNumberOfCoupons(final Long totalNumberOfCoupons) {
        return couponDao.findCouponsByTotalNumberOfCoupons(totalNumberOfCoupons)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public List<Coupon> findCouponsByNumberOfCouponsSold(final Long numberOfCouponsSold) {
        return couponDao.findCouponsByNumberOfCouponsSold(numberOfCouponsSold)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toCouponObject)
                .toList();
    }

    @Override
    public Example save(final String name) {
        final var newEntity = new ExampleEntity();
        newEntity.setName(name);
        return toExampleObject(exampleDao.save(newEntity));
    }

    @Override
    public Coupon save(final String couponType) {
        final var newCoupon = new Coupon();
        newCoupon.setCouponType(couponType);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final Long percentageOff) {
        final var newCoupon = new Coupon();
        newCoupon.setCouponPercentageOff(percentageOff);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final Long dollarsOff) {
        final var newCoupon = new Coupon();
        newCoupon.setCouponDollarsOff(dollarsOff);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final String couponInfo) {
        final var newCoupon = new Coupon();
        newCoupon.setInfo(couponInfo);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final String foodCategories) {
        final var newCoupon = new Coupon();
        newCoupon.setCouponFoodCategories(foodCategories);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final Long numberOfCouponsPerCustomer) {
        final var newCoupon = new Coupon();
        newCoupon.setNumberOfCouponsPerCustomer(numberOfCouponsPerCustomer);
        return toCouponObject(couponDao.save(newCoupon));
    }

    @Override
    public Coupon save(final Long numberOfCouponsSold) {
        final var newCoupon = new Coupon();
        newCoupon.setNumberOfCouponsSold(numberOfCouponsSold);
        return toCouponObject(couponDao.save(newCoupon));
    }

    private Example toExampleObject(final ExampleEntity entity) {
        final var newExampleObject = new Example();
        newExampleObject.setName(entity.getName());
        return newExampleObject;
    }
}
