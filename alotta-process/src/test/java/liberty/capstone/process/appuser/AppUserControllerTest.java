package liberty.capstone.process.appuser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import liberty.capstone.core.appuser.AppUser;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class AppUserControllerTest {
    @Autowired
    private AppUserController appUserController;

    @Test
    void appUserControllerCanSave() {
        final var user = new AppUser();
        user.setUsername("test");
        user.setPassword("password");
        user.setAccountType("Consumer");
        user.setFirstName("Dean");
        user.setLastName("Natale");
        user.setEmail("danatale@liberty.edu");
        user.setPhoneNumber("5404218636");
        user.setZipcode("24515");

        final var result = appUserController.saveAppUser(user);
        assertAll(() -> {
            assertEquals(user.getUsername(), result.getUsername());
            assertEquals(user.getPassword(), result.getPassword());
            assertEquals(user.getAccountType(), result.getAccountType());
            assertEquals(user.getFirstName(), result.getFirstName());
            assertEquals(user.getLastName(), result.getLastName());
            assertEquals(user.getEmail(), result.getEmail());
            assertEquals(user.getPhoneNumber(), result.getPhoneNumber());
            assertEquals(user.getZipcode(), result.getZipcode());
        });
    }

}