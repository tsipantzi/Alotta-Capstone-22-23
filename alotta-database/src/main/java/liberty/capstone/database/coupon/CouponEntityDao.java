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
    List<CouponEntity> findAllByTerm(@Param("term") String term, @Param("date") String date);
    
    @Query(value = """
                    SELECT * from Coupon WHERE
                    START_DATE IS NOT NULL AND START_DATE <= :date
                    AND END_DATE IS NOT NULL AND END_DATE >= :date
                    """, nativeQuery = true)
    List<CouponEntity> findAllByCurrentlyActive(@Param("date") String date);

    @Query(value = """
                    SELECT * FROM Coupon c 
                    INNER JOIN restaurant_inventory ri ON c.id = ri.coupon_id
                    INNER JOIN restaurant r ON ri.restaurant_id = r.id AND r.ZIP_CODE LIKE :zipcodePrefix%
                    WHERE
                    c.START_DATE IS NOT NULL AND c.START_DATE <= :date
                    AND c.END_DATE IS NOT NULL AND c.END_DATE >= :date
                    AND (
                    c.TITLE LIKE %:term%
                    OR c.COUPON_TYPE LIKE %:term%
                    OR c.COUPON_INFO LIKE %:term%
                    OR c.FOOD_CATEGORIES LIKE %:term%)
                    """, nativeQuery = true)
    List<CouponEntity> findAllByTermZipCodeOrEndDate(@Param("term") String term,
                                                     @Param("zipcodePrefix") String zipcodePrefix,
                                                     @Param("date") String date);

    @Query(value = """
                    SELECT * FROM Coupon c 
                    INNER JOIN restaurant_inventory ri ON c.id = ri.coupon_id
                    INNER JOIN restaurant r ON ri.restaurant_id = r.id AND r.ZIP_CODE LIKE :zipcodePrefix%
                    WHERE
                    c.START_DATE IS NOT NULL AND c.START_DATE <= :date
                    AND c.END_DATE IS NOT NULL AND c.END_DATE >= :date
                    """, nativeQuery = true)
    List<CouponEntity> findAllByZipCodeOrEndDate(@Param("zipcodePrefix") String zipcodePrefix,
                                                     @Param("date") String date);

}
