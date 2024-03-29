package liberty.capstone.database.appuser;

import liberty.capstone.core.appuser.AppUser;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@Table(name = "AppUser")
@NoArgsConstructor
public class AppUserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    private String username;
    private String password;
    private String accountType;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String zipcode;

    public AppUserEntity(final AppUser domainObject) {
        this.id = domainObject.getId();
        this.username = domainObject.getUsername();
        this.password = domainObject.getPassword();
        this.accountType = domainObject.getAccountType();
        this.firstName = domainObject.getFirstName();
        this.lastName = domainObject.getLastName();
        this.email = domainObject.getEmail();
        this.phoneNumber = domainObject.getPhoneNumber();
        this.zipcode = domainObject.getZipcode();
    }

    public AppUser toDomainObject() {
        final AppUser domainUser = new AppUser();
        domainUser.setId(id);
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
