package liberty.capstone.database.appuser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@Sql(scripts = "/user-setup.sql")
class UserDaoTest {
    @Autowired
    private UserDao userDao;

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
        userDao.save(entity);

        assertTrue(userDao.findById(entity.getId()).isPresent());
    }

}
