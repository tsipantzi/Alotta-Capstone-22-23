package liberty.capstone.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@Sql(scripts = "/example-setup.sql")
class ExampleDaoTest {
    @Autowired
    private ExampleDao exampleDao;

    @Test
    void saveExample() {
        final ExampleEntity entity = new ExampleEntity();
        entity.setName("Example One");
        exampleDao.save(entity);

        assertTrue(exampleDao.findById(entity.getId()).isPresent());
    }

}