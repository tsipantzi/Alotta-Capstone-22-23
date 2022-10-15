package liberty.capstone.restaurant;

import lombok.Data;

import javax.persistence.*;
import java.sql.Blob;

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
}
