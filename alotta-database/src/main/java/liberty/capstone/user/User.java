package liberty.capstone.user;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String password;
    private String accountType;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String zipcode;
}
