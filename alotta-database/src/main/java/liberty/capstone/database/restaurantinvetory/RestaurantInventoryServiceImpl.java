package liberty.capstone.database.restaurantinvetory;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.coupon.CouponEntityDao;
import liberty.capstone.database.restaurant.RestaurantEntity;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RestaurantInventoryServiceImpl implements RestaurantInventoryService {
    private final RestaurantEntityDao restaurantDao;
    private final CouponEntityDao couponDao;
    private final RestaurantInventoryEntityDao restaurantInventoryDao;

    @Override
    public List<RestaurantInventory> getRestaurantInventoryById(final Long restaurantId) {
        final var restaurant = restaurantDao.findById(restaurantId)
                .orElseThrow();
        return restaurantInventoryDao.findAllByRestaurantIs(restaurant).stream()
                .map(this::toRestaurantInventoryObject)
                .collect(Collectors.toList());
    }

    @Override
    public RestaurantInventory saveInventoryItem(final Long restaurantId,
                                                 final Long couponId,
                                                 final LocalDate startDate,
                                                 final LocalDate endDate) {
        final var restaurant = restaurantDao.findById(restaurantId).orElseThrow();
        final var coupon = couponDao.findById(couponId).orElseThrow();
        final var restaurantInventoryEntityToSave = restaurantInventoryDao
                .findAllByRestaurantIsAndCouponIs(restaurant, coupon)
                .orElse(new RestaurantInventoryEntity());
        restaurantInventoryEntityToSave.setRestaurant(restaurant);
        restaurantInventoryEntityToSave.setCoupon(coupon);
        restaurantInventoryEntityToSave.setStartDate(startDate);
        restaurantInventoryEntityToSave.setEndDate(endDate);
        return toRestaurantInventoryObject(restaurantInventoryDao.saveAndFlush(restaurantInventoryEntityToSave));
    }

    private RestaurantInventory toRestaurantInventoryObject(final RestaurantInventoryEntity entity) {
        final var restaurantInventory = new RestaurantInventory();
        restaurantInventory.setRestaurant(toRestaurantObject(entity.getRestaurant()));
        restaurantInventory.setCoupon(toCouponObject(entity.getCoupon()));
        restaurantInventory.setStartDate(entity.getStartDate());
        restaurantInventory.setEndDate(entity.getEndDate());
        return restaurantInventory;
    }

    private Restaurant toRestaurantObject(final RestaurantEntity entity) {
        final var restaurant = new Restaurant();
        restaurant.setId(entity.getId());
        restaurant.setName(entity.getName());
        restaurant.setPhoneNumber(entity.getPhoneNumber());
        restaurant.setAboutMe(entity.getAboutMe());
        restaurant.setFoodCategories(entity.getFoodCategories());
        restaurant.setEmail(entity.getEmail());
        restaurant.setMaxCateringSizePerPerson(entity.getMaxCateringSizePerPerson());
        restaurant.setMinimumNotice(entity.getMinimumNotice());
        restaurant.setZipCode(entity.getZipCode());
        return restaurant;
    }

    private Coupon toCouponObject(final CouponEntity couponEntity) {
        final var coupon = new Coupon();
        coupon.setId(couponEntity.getId());
        coupon.setTitle(couponEntity.getTitle());
        coupon.setCouponType(couponEntity.getCouponType());
        coupon.setPercentageOff(couponEntity.getPercentageOff());
        coupon.setDollarsOff(couponEntity.getDollarsOff());
        coupon.setCouponInfo(couponEntity.getCouponInfo());
        coupon.setFoodCategories(couponEntity.getFoodCategories());
        coupon.setNumberOfCouponsPerCustomer(couponEntity.getNumberOfCouponsPerCustomer());
        coupon.setTotalNumberOfCoupons(couponEntity.getTotalNumberOfCoupons());
        coupon.setNumberOfCouponsSold(couponEntity.getNumberOfCouponsSold());
        coupon.setStartDate(couponEntity.getStartDate());
        coupon.setEndDate(couponEntity.getEndDate());
        return coupon;
    }
}
