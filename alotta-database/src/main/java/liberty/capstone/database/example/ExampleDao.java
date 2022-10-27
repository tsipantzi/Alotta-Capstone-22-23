package liberty.capstone.database.example;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ExampleDao extends JpaRepository<ExampleEntity, Long> {
    List<ExampleEntity> findAllByName(String name);
}
