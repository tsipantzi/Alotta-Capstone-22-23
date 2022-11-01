package liberty.capstone.database.restaurant;

import liberty.capstone.database.restaurantinvetory.RestaurantInventoryEntity;
import lombok.Data;

import javax.persistence.*;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "restaurant")
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
    private List<RestaurantInventoryEntity> inventory = new ArrayList<>();

    public void addInventory(final RestaurantInventoryEntity inventoryItem) {
        inventory.add(inventoryItem);
        inventoryItem.setRestaurant(this);
    }

    public void removeInventory(final RestaurantInventoryEntity inventoryItem) {
        inventory.remove(inventoryItem);
        inventoryItem.setRestaurant(null);
    }
}