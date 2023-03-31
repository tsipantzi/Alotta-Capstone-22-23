package liberty.capstone.database.customerinventory;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;

import liberty.capstone.database.appuser.AppUserEntity;
import liberty.capstone.database.coupon.CouponEntity;

import liberty.capstone.core.customerinventory.CustomerInventory;

@Data
@Entity
@Slf4j
@NoArgsConstructor
@Table(name = "CustomerInventory")
public class CustomerInventoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @JoinColumn(referencedColumnName = "id")
    @OneToOne(fetch = FetchType.LAZY)
    private CouponEntity coupon;
    @JoinColumn(referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private AppUserEntity customer;
    private boolean redeemed;

    public CustomerInventoryEntity(final CouponEntity couponEntity,
                                    final AppUserEntity appUserEntity) {
        this.coupon = couponEntity;
        this.customer = appUserEntity;
    }

    public CustomerInventory toDomainObject() {
        final var customerInventory = new CustomerInventory();
        customerInventory.setCustomer(customer.toDomainObject());
        customerInventory.setCoupon(coupon.toDomainObject());
        customerInventory.setRedeemed(redeemed);
        log.info("Converted CustomerInventory to domain object : {}", customerInventory);
        return customerInventory;
    }
}
