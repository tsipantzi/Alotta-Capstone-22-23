package liberty.capstone.database.appuser;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<AppUserEntity, Long> {
    Optional<AppUserEntity> findByUsername(String username);
    List<AppUserEntity> findAllByUsername(String username);
}
