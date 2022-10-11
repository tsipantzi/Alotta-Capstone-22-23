package liberty.capstone.user;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@Sql(scripts = "/user-setup.sql")
class UserDaoTest {
    @Autowired
    private UserDao UserDao;

    @Test
    void saveUser() {
        final UserEntity entity = new UserEntity();
        entity.setUsername("TestName");
        userDao.save(entity);

        assertTrue(userDao.findById(entity.getId()).isPresent());
    }

}