package liberty.capstone.core.customerinventory;

import liberty.capstone.core.appuser.AppUser;
import liberty.capstone.core.coupon.Coupon;
import lombok.Data;

@Data
public class CustomerInventory {
    private Coupon coupon;
    private AppUser customer;
    private boolean redeemed;
}
