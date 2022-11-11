package liberty.capstone.database.appuser;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "appuser")
public class AppUserEntity {
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
