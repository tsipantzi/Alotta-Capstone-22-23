package liberty.capstone.process.appuser;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/appuser")
public class AppUserController {
    private final AppUserService appUserService;

    @GetMapping
    public AppUser getExamplesByName(@RequestParam final String username) {
        final var objectReceived = appUserService.findExamplesByName(username);
        log.warn("Got object from database as : {}", objectReceived);
        return objectReceived.stream().findFirst().orElseThrow();
    }

    @PostMapping("/create")
    public AppUser saveAppUser(@RequestBody final AppUser user) {
        final var objectSaved = appUserService.save(user);
        log.warn("Saved object into database as : {}", objectSaved);
        return objectSaved;
    }

    @PostMapping("/update")
    public AppUser updateAppUser(@RequestBody final AppUser user) {
        final var objectSaved = appUserService.updateUser(user);
        log.warn("Updated object into database as : {}", objectSaved);
        return objectSaved;
    }

}
