package liberty.capstone.process.userrestaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/user/restaurants")
public class UserRestaurantController {
    private final UserRestaurantService userRestaurantService;

    @GetMapping
    public List<Restaurant> getAllRestaurants(@RequestParam(required = false) final Long userId,
                                              @RequestParam(required = false) final String zipCode) {
        if (userId == null && zipCode == null) {
            throw new IllegalArgumentException("Must provide either userId or zipCode");
        }

        return userId != null
                ? userRestaurantService.getRestaurantsForUserByUserId(userId)
                    .stream()
                    .map(UserRestaurant::getRestaurant)
                    .collect(Collectors.toList())
                : userRestaurantService.getAllRestaurantsForZipCode(zipCode);
    }
    
    @PostMapping
    public UserRestaurant saveRestaurantForUser(@RequestBody final UserRestaurant userRestaurant) {
        return userRestaurantService.saveRestaurant(userRestaurant);
    }

    @PutMapping
    public UserRestaurant updateRestaurantForUser(@RequestBody final UserRestaurant userRestaurant) {
        return userRestaurantService.updateRestaurant(userRestaurant);
    }

    @DeleteMapping
    public ResponseEntity deleteRestaurantForUser(@RequestBody final UserRestaurant userRestaurant) {
        userRestaurantService.deleteRestaurant(userRestaurant);
        return ResponseEntity.ok().build();
    }
}
