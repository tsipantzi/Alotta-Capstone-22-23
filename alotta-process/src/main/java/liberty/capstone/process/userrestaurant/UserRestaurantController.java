package liberty.capstone.process.userrestaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    public List<Restaurant> getRestaurantsForUser(@RequestParam final Long userId) {
        return userRestaurantService.getRestaurantsForUserByUserId(userId).stream()
            .map(UserRestaurant::getRestaurant).collect(Collectors.toList());
    }
    
    @PostMapping
    public UserRestaurant saveRestaurantForUser(@RequestBody final UserRestaurant userRestaurant) {
        return userRestaurantService.saveRestaurant(userRestaurant);
    }

    @PutMapping
    public UserRestaurant updateRestaurantForUser(@RequestBody final UserRestaurant userRestaurant) {
        return userRestaurantService.updateRestaurant(userRestaurant);
    }
}
