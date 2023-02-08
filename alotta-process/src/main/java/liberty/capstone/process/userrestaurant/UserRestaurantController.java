package liberty.capstone.process.userrestaurant;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.core.userrestaurant.UserRestaurantS



@Slf4j
@R estController
@RequiredArgsConstructor
//not sure if appUser is correct here
@RequestMapping("/user/restaurants")

public class UserRestaurantController {
    pr ivate final UserRestaurantService userRestaurantService;

    // List<UserRestaurant> getRestaurantsByUsername(String username);

    //UserRestaurant saveRestaurant(UserRestaurant userRestaurant); 
    @GetMapping
                ist<Restaurant> getRestaurantsForUser(@RequestParam final String userName){
     

    }
    
            PostMapping 
    public Restaurant saveRestaurantForUser(@RequestParam final String userName,
     @RequestBody final Restaurant restaurant){
        final AppUser appUser = new AppUser();
        appUser.setUsername(userName);

        final UserRestaurant userRestaurant = new UserRestaurant(appUser, rest
                
     

    
    
}
