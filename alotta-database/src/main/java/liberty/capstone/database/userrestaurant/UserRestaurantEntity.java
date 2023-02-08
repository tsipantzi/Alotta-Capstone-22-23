package liberty.capstone.database.userrestaurant;

import javax.persistence.*;

import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.restaurant.RestaurantEntity;
import lombok.Data;

@Entity
@Data
@Table(name = "UserRestaurant")
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
}
