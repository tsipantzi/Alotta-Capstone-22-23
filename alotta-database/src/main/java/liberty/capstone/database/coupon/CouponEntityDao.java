package liberty.capstone.database.coupon;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CouponEntityDao extends JpaRepository<CouponEntity, Long> {

    @Query(value = """
    SELECT * from Coupon WHERE
    START_DATE IS NOT NULL AND START_DATE <= :date
    AND END_DATE IS NOT NULL AND END_DATE >= :date
    AND (
    TITLE LIKE %:term%
    OR COUPON_TYPE LIKE %:term%
    OR COUPON_INFO LIKE %:term%
    OR FOOD_CATEGORIES LIKE %:term%)
    """, nativeQuery = true)
    List<CouponEntity> findAllByTerm(@Param("term") String term, final String date);
    
    @Query(value = """
    SELECT * from Coupon WHERE
    START_DATE IS NOT NULL AND START_DATE <= :date
    AND END_DATE IS NOT NULL AND END_DATE >= :date
    """, nativeQuery = true)
    List<CouponEntity> findAllByCurrentlyActive(final String date);

}
