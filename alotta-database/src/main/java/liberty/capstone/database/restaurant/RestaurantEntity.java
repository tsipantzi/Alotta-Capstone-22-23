package liberty.capstone.database.restaurant;

import liberty.capstone.core.restaurant.Restaurant;
import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.security.SecureRandom;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "Restaurant")
@NoArgsConstructor
@ToString
public class RestaurantEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String phoneNumber;
    private String aboutMe;
    private String foodCategories;
    private String email;
    @Lob
    private Blob logo;
    private Long maxCateringSizePerPerson;
    private Long minimumNotice;
    private String zipCode;

    @OneToMany(mappedBy = "restaurant")
    @ToString.Exclude
    private List<RestaurantInventoryEntity> inventory;

    public RestaurantEntity(final Restaurant restaurant) {
        this.id = restaurant.getId();
        this.name = restaurant.getName();
        this.phoneNumber = restaurant.getPhoneNumber();
        this.aboutMe = restaurant.getAboutMe();
        this.foodCategories = restaurant.getFoodCategories();
        this.email = restaurant.getEmail();
        this.maxCateringSizePerPerson = restaurant.getMaxCateringSizePerPerson();
        this.minimumNotice = restaurant.getMinimumNotice();
        this.zipCode = restaurant.getZipCode();
    }

    public Restaurant toDomainObject() {
        final Restaurant domainRestaurant = new Restaurant();
        domainRestaurant.setId(id);
        domainRestaurant.setName(name);
        domainRestaurant.setPhoneNumber(phoneNumber);
        domainRestaurant.setAboutMe(aboutMe);
        domainRestaurant.setFoodCategories(foodCategories);
        domainRestaurant.setEmail(email);
        domainRestaurant.setMaxCateringSizePerPerson(maxCateringSizePerPerson);
        domainRestaurant.setMinimumNotice(minimumNotice);
        domainRestaurant.setZipCode(zipCode);
        return domainRestaurant;
    }
}
