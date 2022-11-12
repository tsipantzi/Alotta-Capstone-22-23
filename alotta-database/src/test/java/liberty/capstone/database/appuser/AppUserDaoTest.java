package liberty.capstone.database.appuser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@Sql(scripts = "/user-setup.sql")
class AppUserDaoTest {
    @Autowired
    private AppUserDao appUserDao;

    @Test
    void saveUser() {
        final AppUserEntity entity = new AppUserEntity();
        entity.setUsername("TestName");
        entity.setPassword("password");
        entity.setAccountType("Business");
        entity.setFirstName("Dean");
        entity.setLastName("Natale");
        entity.setEmail("danatale@liberty.edu");
        entity.setPhoneNumber("5404218636");
        entity.setZipcode("24515");
        appUserDao.save(entity);

        assertTrue(appUserDao.findById(entity.getId()).isPresent());
    }

}
