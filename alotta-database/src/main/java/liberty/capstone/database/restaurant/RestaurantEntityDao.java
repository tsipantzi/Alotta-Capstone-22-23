package liberty.capstone.database.restaurant;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface RestaurantEntityDao extends JpaRepository<RestaurantEntity, Long> {
    Optional<RestaurantEntity> findByName(String name);
    List<RestaurantEntity> findAllByName(String name);

    List<RestaurantEntity> findAllByZipCodeLike(String zipCode);
}
