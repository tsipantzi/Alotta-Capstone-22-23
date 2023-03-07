package liberty.capstone.database.coupon;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CouponEntityDao extends JpaRepository<CouponEntity, Long> {

    @Query(value = " SELECT * from Coupon where title LIKE %:term% 
    OR couponType LIKE %:term% 
    OR couponInfo LIKE %:term% 
    OR foodCategories LIKE %:term% 
    OR startDate LIKE %:term% 
    OR endDate LIKE %:term% ")
    List<CouponEntity> findAllByTerm(String term);
    
}
