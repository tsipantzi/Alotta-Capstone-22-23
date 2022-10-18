package liberty.capstone.example;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public final class ExampleServiceImpl implements ExampleService {
    private final ExampleDao exampleDao;

    public ExampleServiceImpl(final ExampleDao exampleDao) {
        this.exampleDao = exampleDao;
    }

    @Override
    public List<Example> findExamplesByName(final String name) {
        return exampleDao.findAllByName(name)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toExampleObject)
                .toList();
    }

    @Override
    public Example save(final String name) {
        final var newEntity = new ExampleEntity();
        newEntity.setName(name);
        return toExampleObject(exampleDao.save(newEntity));
    }

    private Example toExampleObject(final ExampleEntity entity) {
        final var newExampleObject = new Example();
        newExampleObject.setName(entity.getName());
        return newExampleObject;
    }
}