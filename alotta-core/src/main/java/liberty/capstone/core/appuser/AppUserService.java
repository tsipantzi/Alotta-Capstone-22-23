package liberty.capstone.core.appuser;

import java.util.List;

public interface AppUserService {
    List<AppUser> findExamplesByName(String username);

    AppUser save(AppUser user);

    AppUser updateUser(AppUser user);
}
