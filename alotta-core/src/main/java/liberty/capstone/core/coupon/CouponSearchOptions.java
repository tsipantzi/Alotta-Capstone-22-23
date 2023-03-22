package liberty.capstone.core.coupon;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class CouponSearchOptions {
    private final String zipCode;
    private final LocalDateTime endDate;
}
