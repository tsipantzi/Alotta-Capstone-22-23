package liberty.capstone.database.userrestaurant;

import liberty.capstone.core.userrestaurant.UserRestaurant;
import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@Table(name = "UserRestaurant")
@NoArgsConstructor
public class UserRestaurantEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private AppUserEntity appUser;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private RestaurantEntity restaurant;

    public UserRestaurantEntity(final AppUserEntity appUser,
                                final RestaurantEntity restaurant) {
        this.appUser = appUser;
        this.restaurant = restaurant;
    }

    public UserRestaurant toDomainObject() {
        return new UserRestaurant(
                this.appUser.toDomainObject(),
                this.restaurant.toDomainObject());

    }
}
