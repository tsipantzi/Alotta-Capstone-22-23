package liberty.capstone.core.userrestaurant;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.restaurant.Restaurant;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
public class UserRestaurant {
    private AppUser appUser;
    private Restaurant restaurant;
}
