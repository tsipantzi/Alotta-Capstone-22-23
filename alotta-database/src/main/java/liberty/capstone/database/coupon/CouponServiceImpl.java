package liberty.capstone.database.coupon;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntityDao;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {

    private final CouponEntityDao couponDao;
    private final RestaurantInventoryEntityDao inventoryDao;
    private final RestaurantEntityDao restaurantDao;

    @Override
    public List<Coupon> getAllCouponsForRestaurant(final Long restaurantId) {
        final var restaurant = restaurantDao.findById(restaurantId).orElseThrow();
        final var inventory = inventoryDao.findAllByRestaurantIs(restaurant);
        return inventory.stream().map(RestaurantInventoryEntity::getCoupon)
                .map(this::toCouponObject).collect(Collectors.toList());
    }

    @Override
    public Coupon getCouponForRestaurant(final Long couponId) {
        final var coupon = couponDao.findById(couponId).orElseThrow();
        return toCouponObject(coupon);
    }

    @Override
    public Coupon saveCoupon(final Long restaurantId, final Coupon coupon, final LocalDate startDate,
            final LocalDate endDate) {
        // need to save the coupon to inventory and coupon
        final var restaurant = restaurantDao.findById(restaurantId)
                .orElseThrow(() -> new IllegalArgumentException("Restaurant Does not exist"));

        final var foundCoupon = couponDao.findById(coupon.getId()).orElse(new CouponEntity());
        foundCoupon.setCouponType(coupon.getCouponType());
        foundCoupon.setPercentageOff(coupon.getPercentageOff());
        foundCoupon.setDollarsOff(coupon.getDollarsOff());
        foundCoupon.setCouponInfo(coupon.getCouponInfo());
        foundCoupon.setFoodCategories(coupon.getFoodCategories());
        foundCoupon.setNumberOfCouponsPerCustomer(coupon.getNumberOfCouponsPerCustomer());
        foundCoupon.setTotalNumberOfCoupons(coupon.getTotalNumberOfCoupons());
        foundCoupon.setNumberOfCouponsSold(coupon.getNumberOfCouponsSold());
        final var savedCoupon = couponDao.save(foundCoupon);

        final var inventory = inventoryDao.findAllByRestaurantIs(restaurant);
        final var couponInInventory = inventory.stream()
                .filter(item -> {
                    return item.getCoupon() != null && savedCoupon.getId().equals(item.getCoupon().getId());
                })
                .findFirst().orElse(new RestaurantInventoryEntity());
        if (couponInInventory.getId() == null) {
            couponInInventory.setCoupon(savedCoupon);
            couponInInventory.setRestaurant(restaurant);
            couponInInventory.setStartDate(startDate);
            couponInInventory.setEndDate(endDate);
        } else {
            couponInInventory.setStartDate(startDate);
            couponInInventory.setEndDate(endDate);
        }
        final var savedInventoryItem = inventoryDao.save(couponInInventory);
        return toCouponObject(savedInventoryItem.getCoupon());
    }

    private Coupon toCouponObject(final CouponEntity couponEntity) {
        final var coupon = new Coupon();
        coupon.setId(couponEntity.getId());
        coupon.setCouponType(couponEntity.getCouponType());
        coupon.setPercentageOff(couponEntity.getPercentageOff());
        coupon.setDollarsOff(couponEntity.getDollarsOff());
        coupon.setCouponInfo(couponEntity.getCouponInfo());
        coupon.setFoodCategories(couponEntity.getFoodCategories());
        coupon.setNumberOfCouponsPerCustomer(couponEntity.getNumberOfCouponsPerCustomer());
        coupon.setTotalNumberOfCoupons(couponEntity.getTotalNumberOfCoupons());
        coupon.setNumberOfCouponsSold(couponEntity.getNumberOfCouponsSold());
        return coupon;
    }
}
