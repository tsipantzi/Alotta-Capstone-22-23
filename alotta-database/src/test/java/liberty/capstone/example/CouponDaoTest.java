package liberty.capstone.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@Sql(scripts = "/coupon.sql")
class CouponTest {
    @Autowired
    private CouponDao couponDao;

    @Test
    void saveExample() {
        final Coupon entity = new Coupon();
        entity.setCouponType("This is a test of the Type field");
        entity.setPercentageOff((long) 74);
        entity.setDollarsOff((long)10.25);
        entity.setCouponInfo("This is a test of the info field");
        entity.setFoodCategories("American");
        entity.setNumberOfCouponsPerCustomer((long)11);
        entity.setTotalNumberOfCoupons((long)12);
        entity.setNumberOfCouponsSold((long)11.0);
    
        couponDao.save(entity);

        assertTrue(CouponDao.findById(entity.getId()).isPresent());
    }

}