package liberty.capstone.database.customerinventory;

import liberty.capstone.database.coupon.CouponEntity;
import liberty.capstone.database.coupon.CouponEntityDao;
import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.appuser.AppUserDao;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@Slf4j
@DataJpaTest
@Sql(scripts = "/customer-inventory-setup.sql")
class CustomerInventoryEntityDaoTest {
    @Autowired
    CustomerInventoryEntityDao inventoryEntityDao;
    @Autowired
    CouponEntityDao couponDao;
    @Autowired
    AppUserDao customerDao;

    @Test
    void canSaveInventoryEntity() {
        final var customer = new AppUserEntity();
        customer.setUsername("TestName");
        customer.setPassword("password");
        customer.setAccountType("Business");
        customer.setFirstName("Dean");
        customer.setLastName("Natale");
        customer.setEmail("danatale@liberty.edu");
        customer.setPhoneNumber("5404218636");
        customer.setZipcode("24515");

        final var coupon = new CouponEntity();
        coupon.setCouponInfo("This is the coupon info");

        final var savedCustomer = customerDao.save(customer);
        final var savedCoupon = couponDao.save(coupon);
        final var customerInventory = new CustomerInventoryEntity();
        customerInventory.setCustomer(savedCustomer);
        customerInventory.setCoupon(savedCoupon);
        inventoryEntityDao.save(customerInventory);

        final var result = inventoryEntityDao.findAll().get(0);
        assertAll(() -> {
            assertEquals(savedCustomer.getId(), result.getCustomer().getId());
            assertEquals(savedCustomer.getUsername(), result.getCustomer().getUsername());
            assertEquals(savedCustomer.getPassword(), result.getCustomer().getPassword());
            assertEquals(savedCustomer.getAccountType(), result.getCustomer().getAccountType());
            assertEquals(savedCustomer.getFirstName(), result.getCustomer().getFirstName());
            assertEquals(savedCustomer.getLastName(), result.getCustomer().getLastName());
            assertEquals(savedCustomer.getEmail(), result.getCustomer().getEmail());
            assertEquals(savedCustomer.getPhoneNumber(), result.getCustomer().getPhoneNumber());
            assertEquals(savedCustomer.getZipcode(), result.getCustomer().getZipcode());

            assertEquals(savedCoupon.getId(), result.getCoupon().getId());
            assertEquals(savedCoupon.getCouponInfo(), result.getCoupon().getCouponInfo());
        });
        log.info("Successfully created CustomerInventory item : {}", result);
    }
}
