package liberty.capstone.database.restaurant;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@Sql(scripts = "/restaurant-setup.sql")
class RestaurantDaoTest {
    @Autowired
    private RestaurantDao restaurantDao;

    @Test
    void saveAndFindByName() {
        final RestaurantEntity entity = new RestaurantEntity();
        entity.setName("Test Restaurant Name");
        entity.setPhoneNumber("123-456-7890");

        var entityToSave = restaurantDao.findByName(entity.getName()).orElse(entity);
        restaurantDao.save(entityToSave);
        assertTrue(restaurantDao.findByName(entity.getName()).isPresent());
    }
}