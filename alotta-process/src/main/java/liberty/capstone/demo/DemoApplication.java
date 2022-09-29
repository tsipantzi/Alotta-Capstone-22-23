package liberty.capstone.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@SuppressWarnings({
        "checkstyle:FinalClass",
        "checkstyle:HideUtilityClassConstructor",
        "PMD.UseUtilityClass"})
public class DemoApplication {
    public static void main(final String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
