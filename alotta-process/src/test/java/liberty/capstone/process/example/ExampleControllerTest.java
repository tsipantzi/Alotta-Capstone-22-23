package liberty.capstone.process.example;

import liberty.capstone.process.example.ExampleController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class ExampleControllerTest {
    @Autowired
    private ExampleController exampleController;

    @Test
    void exampleControllerCanSave() {
        final var result = exampleController.saveExample("test");
        assertEquals("test", result.getName());
    }

    @Test
    void exampleControllerFindAllRecordsAfterSave() {
        exampleController.saveExample("test");
        exampleController.saveExample("test");

        final var result = exampleController.getExamplesByName("test");

        assertAll(() -> {
            assertEquals(2, result.size());
            assertEquals("test", result.get(0).getName());
            assertEquals("test", result.get(1).getName());
        });
    }
}