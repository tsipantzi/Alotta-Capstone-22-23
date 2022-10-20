package liberty.capstone.process.example;

import liberty.capstone.core.example.Example;
import liberty.capstone.core.example.ExampleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/rest/example")
public class ExampleController {
    private final ExampleService exampleService;

    @GetMapping
    public List<Example> getExamplesByName(@RequestParam final String name) {
        final var objectRecieved = exampleService.findExamplesByName(name);
        log.warn("Got object from database as : {}", objectRecieved);
        return objectRecieved;
    }

    @PostMapping("/{name}")
    public Example saveExample(@PathVariable("name") final String name) {
        final var objectSaved = exampleService.save(name);
        log.warn("Saved object into database as : {}", objectSaved);
        return objectSaved;
    }
}
