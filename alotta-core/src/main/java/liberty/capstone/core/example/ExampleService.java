package liberty.capstone.core.example;

import java.util.List;

public interface ExampleService {
    List<Example> findExamplesByName(String name);

    Example save(String name);
}
