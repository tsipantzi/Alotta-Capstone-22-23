package liberty.capstone.database.appuser;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;

import java.util.List;

@Slf4j
@Service
public final class AppUserServiceImpl implements AppUserService {
    private final UserDao userDao;

    public AppUserServiceImpl(final UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public List<AppUser> findExamplesByName(final String name) {
        return userDao.findAllByUsername(name)
                .stream()
                .peek(entity -> log.info("Found entity in database : {}", entity))
                .map(this::toUserObject)
                .toList();
    }

    @Override
    public AppUser save(final AppUser user) {
        final var savedUserEntity = userDao.save(toUserEntity(user));
        return toUserObject(savedUserEntity);
    }

    private AppUser toUserObject(final AppUserEntity entity) {
        final var newUserObject = new AppUser();
        newUserObject.setUsername(entity.getUsername());
        return newUserObject;
    }

    private AppUserEntity toUserEntity(final AppUser user) {
        final var newUserEntity = new AppUserEntity();
        newUserEntity.setUsername(user.getUsername());
        return newUserEntity;
    }
}
