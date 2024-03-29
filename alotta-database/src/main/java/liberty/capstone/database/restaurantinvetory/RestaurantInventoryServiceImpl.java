package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.coupon.CouponEntityDao;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class RestaurantInventoryServiceImpl implements RestaurantInventoryService {
    public static final String INVALID_RESTAURANT = "Restaurant %s does not exist";
    private final RestaurantEntityDao restaurantDao;
    private final CouponEntityDao couponDao;
    private final RestaurantInventoryEntityDao restaurantInventoryDao;

    @Override
    @Transactional
    public List<Coupon> findAllCouponsByRestaurantId(final Long restaurantId) {
        restaurantDao.findById(restaurantId)
                .orElseThrow(() -> new IllegalArgumentException(String.format(INVALID_RESTAURANT, restaurantId)));

        return restaurantInventoryDao.findAllByRestaurant_Id(restaurantId)
                .stream()
                .map(RestaurantInventoryEntity::toDomainObject)
                .map(RestaurantInventory::getCoupon)
                .collect(Collectors.toList());
    }

    @Override
    public Coupon saveCoupon(final Long restaurantId, final Coupon coupon) {
        final var restaurant = restaurantDao.findById(restaurantId)
                .orElseThrow(() -> new IllegalArgumentException(String.format(INVALID_RESTAURANT, restaurantId)));
        final var savedCoupon = couponDao.saveAndFlush(new CouponEntity(coupon));
        log.info(String.format("Saved coupon: %s", savedCoupon));
        final var savedRestaurantInventory = this.saveInventoryItem(restaurant,
                savedCoupon,
                coupon.getStartDate(),
                coupon.getEndDate());
        log.info(String.format("Saved inventory: %s", savedRestaurantInventory));
        return savedRestaurantInventory.toDomainObject().getCoupon();
    }

    @Override
    public void deleteCoupon(final Long restaurantId, final Coupon coupon) {
        final var restaurant = restaurantDao.findById(restaurantId)
                .orElseThrow(() -> new IllegalArgumentException(String.format(INVALID_RESTAURANT, restaurantId)));
        final var couponToDelete = couponDao.findById(coupon.getId())
                .orElseThrow(() -> new IllegalArgumentException("Coupon Does not exist"));
        final var restaurantInventoryToDelete = restaurantInventoryDao.findByRestaurantAndCoupon(restaurant,
                        couponToDelete)
                .orElseThrow(() -> new IllegalArgumentException("Restaurant Inventory Does not exist"));
        restaurantInventoryDao.delete(restaurantInventoryToDelete);
    }

    private RestaurantInventoryEntity saveInventoryItem(final RestaurantEntity restaurant,
                                   final CouponEntity coupon,
                                   final LocalDate startDate,
                                   final LocalDate endDate) {
        final var restaurantInventoryEntityToSave = new RestaurantInventoryEntity();
        restaurantInventoryEntityToSave.setRestaurant(restaurant);
        restaurantInventoryEntityToSave.setCoupon(coupon);
        restaurantInventoryEntityToSave.setStartDate(startDate);
        restaurantInventoryEntityToSave.setEndDate(endDate);
        return restaurantInventoryDao.saveAndFlush(restaurantInventoryEntityToSave);
    }
}
