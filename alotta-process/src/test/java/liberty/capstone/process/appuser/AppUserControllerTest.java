package liberty.capstone.process.appuser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.process.appuser.AppUserController;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class ExampleControllerTest {
    @Autowired
    private AppUserController appUserController;

    @Test
    void appUserControllerCanSave() {
        AppUser user;
        user.setUsername("test");
        user.setPassword("password");
        user.setAccountType("Consumer");
        user.setFirstName("Dean");
        user.setLastName("Natale");
        user.setEmail("danatale@liberty.edu");
        user.setPhoneNumber("5404218636");
        user.setZipcode("24515");

        final var result = appUserController.saveAppUser(user);
        assertEquals("test", result.getUsername());
    }

    @Test
    void appUserControllerFindAllRecordsAfterSave() {
        appUserController.saveAppUser("test");
        appUserController.saveAppUser("test");

        final var result = appUserController.getExamplesByName("test");

        assertAll(() -> {
            assertEquals(2, result.size());
            assertEquals("test", result.get(0).getUsername());
            assertEquals("test", result.get(1).getUsername());
        });
    }
}