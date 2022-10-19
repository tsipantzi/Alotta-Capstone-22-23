package liberty.capstone.example;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExampleDao extends JpaRepository<ExampleEntity, Long> {
    List<ExampleEntity> findAllByName(String name);
}
