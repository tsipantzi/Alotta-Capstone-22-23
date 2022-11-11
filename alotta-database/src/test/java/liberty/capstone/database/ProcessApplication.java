package liberty.capstone.database;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@SuppressWarnings({
        "checkstyle:FinalClass",
        "checkstyle:HideUtilityClassConstructor",
        "PMD.UseUtilityClass"})
public class ProcessApplication {
    public static void main(final String[] args) {
        SpringApplication.run(ProcessApplication.class, args);
    }
}
