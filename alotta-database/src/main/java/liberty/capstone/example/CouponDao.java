package liberty.capstone.example;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponDao extends JpaRepository<Coupon, Long> {
}
