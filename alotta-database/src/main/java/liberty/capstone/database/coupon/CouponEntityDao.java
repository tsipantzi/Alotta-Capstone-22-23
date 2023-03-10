package liberty.capstone.database.coupon;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CouponEntityDao extends JpaRepository<CouponEntity, Long> {

    @Query(value = """
    SELECT * from Coupon c WHERE
    c.TITLE LIKE %:term%
    OR c.COUPON_TYPE LIKE %:term%
    OR c.COUPON_INFO LIKE %:term%
    OR c.FOOD_CATEGORIES LIKE %:term%
    """, nativeQuery = true)
    List<CouponEntity> findAllByTerm(@Param("term") String term);
    
}
