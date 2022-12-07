package liberty.capstone.process.appuser;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.*;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/appuser")
public class AppUserController {
    private final AppUserService appUserService;

    @GetMapping
    public AppUser getExamplesByName(@RequestParam final String username) {
        final var objectRecieved = appUserService.findExamplesByName(username);
        log.warn("Got object from database as : {}", objectRecieved);
        return objectRecieved.stream().findFirst().orElseThrow();
    }

    @PostMapping
    public AppUser saveAppUser(@RequestBody final AppUser user) {
        final var objectSaved = appUserService.save(user);
        log.warn("Saved object into database as : {}", objectSaved);
        return objectSaved;
    }
}
