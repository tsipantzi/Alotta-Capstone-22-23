package liberty.capstone.database.appuser;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AppUserDao extends JpaRepository<AppUserEntity, Long> {
    Optional<AppUserEntity> findByUsername(String username);
    Optional<AppUserEntity> findByUsernameAndPassword(String username, String password);
}
