package liberty.capstone.core.restaurant;

import lombok.Data;

@Data
public class Restaurant {
    private Long id;
    private String name;
    private String phoneNumber;
    private String aboutMe;
    private String foodCategories;
    private String email;
    private Long maxCateringSizePerPerson;
    private Long minimumNotice;
    private String zipCode;
}
