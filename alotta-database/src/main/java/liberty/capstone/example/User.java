package liberty.capstone.example;

import lombok.Data;

import javax.persistence.*;

Entity
@Data
@Table(name = "User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String Username;
    private String Password;
    private String AccountType;
    private String FirstName;
    private String LastName;
    private String Email;
    private String PhoneNumber;
    private Char Zipcode;
}