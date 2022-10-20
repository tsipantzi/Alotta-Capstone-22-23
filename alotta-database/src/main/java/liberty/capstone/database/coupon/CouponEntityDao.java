package liberty.capstone.database.coupon;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponEntityDao extends JpaRepository<CouponEntity, Long> {
    
}
