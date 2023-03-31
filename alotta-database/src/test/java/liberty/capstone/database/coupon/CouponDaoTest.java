package liberty.capstone.database.coupon;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;

@DataJpaTest
@Slf4j
@Sql(scripts = "/coupon-setup.sql")
class CouponDaoTest {
    static final LocalDate TODAY = LocalDate.now(); 
    @Autowired
    private CouponEntityDao couponDao;

    CouponEntity expectedEntity;
    @BeforeEach
    void BeforeEach(){
        final CouponEntity entity = new CouponEntity();
        entity.setTitle("Test title");
        entity.setCouponType("This is a test of the Type field");
        entity.setPercentageOff((long) 74);
        entity.setDollarsOff((long)10.25);
        entity.setCouponInfo("This is a test of the info field");
        entity.setFoodCategories("American");
        entity.setNumberOfCouponsPerCustomer((long)11);
        entity.setTotalNumberOfCoupons((long)12);
        entity.setNumberOfCouponsSold((long)11.0);
        entity.setStartDate(TODAY.minusDays(3));
        entity.setEndDate(TODAY.plusDays(3));

        expectedEntity = couponDao.saveAndFlush(entity);
    }

    @Test
    void saveExample() {
        assertTrue(couponDao.findById(expectedEntity.getId()).isPresent());
    }

    @Test
    void findAllByTerm(){
        //tests CouponType
        assertFalse(couponDao.findAllByTerm("Type", TODAY.toString()).isEmpty());
        //tests CouponTitle
        assertFalse(couponDao.findAllByTerm("title", TODAY.toString()).isEmpty());
        //tests food Categories
        assertFalse(couponDao.findAllByTerm("American", TODAY.toString()).isEmpty());
        //tests Coupon Info
        assertFalse(couponDao.findAllByTerm("info", TODAY.toString()).isEmpty());
    }

    @Test
    void findAllByCurrentlyActive(){
        final CouponEntity entity = new CouponEntity();
        entity.setTitle("Test title2");
        entity.setCouponType("This is a test of the Type field");
        entity.setPercentageOff((long) 74);
        entity.setDollarsOff((long)10.25);
        entity.setCouponInfo("This is a test of the info field");
        entity.setFoodCategories("American");
        entity.setNumberOfCouponsPerCustomer((long)11);
        entity.setTotalNumberOfCoupons((long)12);
        entity.setNumberOfCouponsSold((long)11.0);
        entity.setStartDate(TODAY.minusDays(3));
        entity.setEndDate(TODAY.minusDays(1));

        final var excludedEntity = couponDao.saveAndFlush(entity);

        final var results = couponDao.findAllByCurrentlyActive(TODAY.toString());

        log.warn("Got results : {}", results);

        assertAll(
            () -> assertTrue(results.contains(expectedEntity)),
            () -> assertFalse(results.contains(excludedEntity)));
    }

}