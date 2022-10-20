package liberty.capstone.process.restaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.restaurant.RestaurantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant")
public class RestaurantController {
    private final RestaurantService restaurantService;

    @GetMapping
    public List<Restaurant> getRestaurantsByName(@RequestParam final String name) {
        final var restaurants = restaurantService.findRestaurantsByName(name);
        log.info("Found restaurants with name {} : {}", name, restaurants);
        return restaurants;
    }

    @PostMapping
    public Restaurant saveRestaurant(@RequestBody final Restaurant restaurant) {
        final var restaurantSaved = restaurantService.saveRestaurant(restaurant);
        log.info("Saved Restaurant into the database as : {}", restaurantSaved);
        return restaurantSaved;
    }
}
