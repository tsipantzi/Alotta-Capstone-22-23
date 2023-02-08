package liberty.capstone.process.userrestaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantService;
import liberty.capstone.core.appuser.AppUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Slf4j
@RestController
@RequiredArgsConstructor
//not sure if appUser is correct here
@RequestMapping("/user/restaurants")

public class UserRestaurantController {
    private final UserRestaurantService userRestaurantService;

    //List<UserRestaurant> getRestaurantsByUsername(String username);

    //UserRestaurant saveRestaurant(UserRestaurant userRestaurant);
    @GetMapping
    public List<Restaurant> getRestaurantsForUser(@RequestParam final String userName){
        return userRestaurantService.getRestaurantsByUsername(userName).stream()
            .map(UserRestaurant::getRestaurant).collect(Collectors.toList());
    }
    
    @PostMapping
    public Restaurant saveRestaurantForUser(@RequestParam final String userName,
     @RequestBody final Restaurant restaurant){
        final AppUser appUser = new AppUser();
        appUser.setUsername(userName);

        final UserRestaurant userRestaurant = new UserRestaurant(appUser, restaurant);

        return Stream.of(userRestaurantService.saveRestaurant(userRestaurant))
        .map(UserRestaurant::getRestaurant).collect(Collectors.toList()).get(0);
    }
    
    
}
