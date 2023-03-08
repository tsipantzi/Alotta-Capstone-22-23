package liberty.capstone.database.coupon;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;


import org.junit.jupiter.api.BeforeEach;

@DataJpaTest
@Sql(scripts = "/coupon-setup.sql")
class CouponDaoTest {
    @Autowired
    private CouponEntityDao couponDao;

    CouponEntity entity;
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
    
        couponDao.save(entity);
    }

    @Test
    void saveExample() {
        assertTrue(couponDao.findById(entity.getId()).isPresent());
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

}