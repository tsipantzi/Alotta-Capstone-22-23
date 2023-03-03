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
    public AppUser getAppUserByUsernameAndPassword(@RequestParam final String username,
                                                   @RequestParam final String password) {
        final var objectReceived = appUserService.findAppUserByUsernameAndPassword(username, password);
        log.warn("Got object from database as : {}", objectReceived);
        return objectReceived;
    }

    @PostMapping("/create")
    public AppUser saveAppUser(@RequestBody final AppUser user) {
        final var objectSaved = appUserService.createAppUser(user);
        log.warn("Saved object into database as : {}", objectSaved);
        return objectSaved;
    }

    @PostMapping("/update")
    public AppUser updateAppUser(@RequestBody final AppUser user) {
        final var objectSaved = appUserService.updateAppUser(user);
        log.warn("Updated object into database as : {}", objectSaved);
        return objectSaved;
    }

}
