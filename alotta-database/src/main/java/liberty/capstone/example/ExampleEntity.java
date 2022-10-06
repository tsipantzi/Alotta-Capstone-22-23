package liberty.capstone.example;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "example")
public class ExampleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
}
