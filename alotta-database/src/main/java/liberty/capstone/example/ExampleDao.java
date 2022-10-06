package liberty.capstone.example;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExampleDao extends JpaRepository<ExampleEntity, Long> {
}
