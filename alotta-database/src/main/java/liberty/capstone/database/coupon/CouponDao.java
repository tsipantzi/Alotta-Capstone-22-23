package liberty.capstone.database.coupon;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponDao extends JpaRepository<Coupon, Long> {
    
}
