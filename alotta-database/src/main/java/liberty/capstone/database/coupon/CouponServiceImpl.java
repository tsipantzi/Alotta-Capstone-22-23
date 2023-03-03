package liberty.capstone.database.coupon;

import liberty.capstone.core.coupon.Coupon;
import liberty.capstone.core.coupon.CouponService;
import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import liberty.capstone.database.restaurant.RestaurantEntityDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {

    private final CouponEntityDao couponDao;
    private final RestaurantInventoryService inventoryService;
    private final RestaurantEntityDao restaurantDao;

    @Override
    public List<Coupon> getAllCouponsForRestaurant(final Long restaurantId) {
        return inventoryService.getRestaurantInventoryById(restaurantId)
                .stream()
                .map(RestaurantInventory::getCoupon)
                .collect(Collectors.toList());
    }

    @Override
    public RestaurantInventory saveCoupon(final Long restaurantId, final Coupon coupon) {
        // need to save the coupon to inventory and coupon
        final var restaurant = restaurantDao.findById(restaurantId)
                .orElseThrow(() -> new IllegalArgumentException("Restaurant Does not exist"));


        final var foundCoupon = coupon.getId() != null
                ? couponDao.findById(coupon.getId()).orElse(new CouponEntity(coupon))
                : new CouponEntity(coupon);

        final var savedCoupon = couponDao.saveAndFlush(foundCoupon);


        return inventoryService.saveInventoryItem(restaurant.getId(),
                        savedCoupon.getId(),
                        coupon.getStartDate(),
                        coupon.getEndDate());
    }
}
