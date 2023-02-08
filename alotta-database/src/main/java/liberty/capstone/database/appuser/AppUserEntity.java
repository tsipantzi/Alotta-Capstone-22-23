package liberty.capstone.database.appuser;

import lombok.Data;
import lombok.var;

import javax.persistence.*;

import liberty.capstone.core.appuser.AppUser;

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

    public AppUser toDomainObject() {
        final var domainUser = new AppUser();
        domainUser.setUsername(username);
        domainUser.setPassword(password);
        domainUser.setAccountType(accountType);
        domainUser.setFirstName(firstName);
        domainUser.setLastName(lastName);
        domainUser.setEmail(email);
        domainUser.setPhoneNumber(phoneNumber);
        domainUser.setZipcode(zipcode);
        return domainUser;
    }
}
