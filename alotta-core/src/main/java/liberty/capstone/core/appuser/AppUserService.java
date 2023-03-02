package liberty.capstone.core.appuser;

import java.util.List;

public interface AppUserService {
    AppUser findAppUserByUsernameAndPassword(String username, String password);

    AppUser createAppUser(AppUser user);
    AppUser updateAppUser(AppUser user);
}
