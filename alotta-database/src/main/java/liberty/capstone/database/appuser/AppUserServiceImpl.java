package liberty.capstone.database.appuser;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.appuser.AppUserService;

import java.util.List;
import java.util.stream.Collectors;

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
                .map(this::toUserObject)
                .collect(Collectors.toList());
    }

    @Override
    public AppUser save(final AppUser user) {
        final var savedUserEntity = userDao.save(toUserEntity(user));
        return toUserObject(savedUserEntity);
    }

    private AppUser toUserObject(final AppUserEntity entity) {
        final var newUserObject = new AppUser();
        newUserObject.setUsername(entity.getUsername());
        newUserObject.setPassword(entity.getPassword());
        newUserObject.setAccountType(entity.getAccountType());
        newUserObject.setFirstName(entity.getFirstName());
        newUserObject.setLastName(entity.getLastName());
        newUserObject.setEmail(entity.getEmail());
        newUserObject.setPhoneNumber(entity.getPhoneNumber());
        newUserObject.setZipcode(entity.getZipcode());
        return newUserObject;
    }

    private AppUserEntity toUserEntity(final AppUser user) {
        final var newUserEntity = new AppUserEntity();
        newUserEntity.setUsername(user.getUsername());
        newUserEntity.setPassword(user.getPassword());
        newUserEntity.setAccountType(user.getAccountType());
        newUserEntity.setFirstName(user.getFirstName());
        newUserEntity.setLastName(user.getLastName());
        newUserEntity.setEmail(user.getEmail());
        newUserEntity.setPhoneNumber(user.getPhoneNumber());
        newUserEntity.setZipcode(user.getZipcode());
        return newUserEntity;
    }
}
