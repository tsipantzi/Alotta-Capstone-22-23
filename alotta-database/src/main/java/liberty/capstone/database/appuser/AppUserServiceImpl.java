package liberty.capstone.database.appuser;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public final class AppUserServiceImpl implements AppUserService {
    private final AppUserDao appUserDao;

    @Override
    public List<AppUser> findExamplesByName(final String name) {
        return appUserDao.findAllByUsername(name)
                .stream()
                .map(AppUserEntity::toDomainObject)
                .collect(Collectors.toList());
    }

    @Override
    public AppUser save(final AppUser user) {
        final var savedUserEntity = appUserDao.saveAndFlush(new AppUserEntity(user));
        return savedUserEntity.toDomainObject();
    }

    @Override
    public AppUser updateUser(final AppUser user) {
        final var existingUserEntity = appUserDao.findByUsername(user.getUsername())
                .orElseThrow(() -> new IllegalArgumentException(String.format(
                        "Could not find the User %s in the database", user.getUsername())));

        return appUserDao.saveAndFlush(AppUserEntity.from(existingUserEntity.getId(), user)).toDomainObject();
    }
}
