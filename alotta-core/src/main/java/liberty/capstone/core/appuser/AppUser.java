package liberty.capstone.core.appuser;

import lombok.Data;

@Data
public class AppUser {
    private String username;
    private String password;
    private String accountType;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String zipcode;
}
