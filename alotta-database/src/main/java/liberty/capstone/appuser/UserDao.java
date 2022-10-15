package liberty.capstone.appuser;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<AppUser, Long> {
}
