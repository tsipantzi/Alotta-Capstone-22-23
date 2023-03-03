package liberty.capstone.core.appuser;

public interface AppUserService {
    AppUser findAppUserByUsernameAndPassword(String username, String password);

    AppUser createAppUser(AppUser user);
    AppUser updateAppUser(AppUser user);
}
