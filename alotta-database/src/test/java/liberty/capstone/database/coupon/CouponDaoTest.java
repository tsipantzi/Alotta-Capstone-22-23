package liberty.capstone.database.coupon;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import lombok.var;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;

@DataJpaTest
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
        assertFalse(couponDao.findAllByTerm("Type").isEmpty());
        //tests CouponTitle
        assertFalse(couponDao.findAllByTerm("title").isEmpty());
        //tests food Categories
        assertFalse(couponDao.findAllByTerm("American").isEmpty());
        //tests Coupon Info
        assertFalse(couponDao.findAllByTerm("info").isEmpty());
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

        final var results = couponDao.findAllByCurrentlyActive();

        assertAll(
            () -> assertTrue(results.contains(expectedEntity)),
            () -> assertFalse(results.contains(excludedEntity))
            );
    }

}