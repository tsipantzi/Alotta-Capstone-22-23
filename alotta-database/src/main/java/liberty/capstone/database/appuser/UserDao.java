package liberty.capstone.database.appuser;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<AppUserEntity, Long> {
    List<AppUserEntity> findAllByUsername(String username);
}
