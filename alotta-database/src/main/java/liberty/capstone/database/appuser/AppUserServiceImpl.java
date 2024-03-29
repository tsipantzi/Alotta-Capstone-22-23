package liberty.capstone.database.appuser;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public final class AppUserServiceImpl implements AppUserService {
    private final AppUserDao appUserDao;

    @Override
    public AppUser findAppUserByUsernameAndPassword(final String username, final String password) {
        return appUserDao.findByUsernameAndPassword(username, password)
                .orElseThrow(() ->
                        new IllegalArgumentException("Could not find a user with the username and password specified"))
                .toDomainObject();
    }

    @Override
    public AppUser createAppUser(final AppUser user) {
        if (appUserDao.findByUsername(user.getUsername()).isPresent()) {
            throw new IllegalArgumentException("Found an existing user that username so a new user cannot be created");
        }

        final AppUserEntity entityToSave = new AppUserEntity(user);

        return appUserDao.saveAndFlush(entityToSave).toDomainObject();
    }

    @Override
    public AppUser updateAppUser(final AppUser user) {
        appUserDao.findById(user.getId()).orElseThrow(() ->
                new IllegalArgumentException("Could not find a user with the specified Id"));

        return appUserDao.saveAndFlush(new AppUserEntity(user)).toDomainObject();
    }
}
