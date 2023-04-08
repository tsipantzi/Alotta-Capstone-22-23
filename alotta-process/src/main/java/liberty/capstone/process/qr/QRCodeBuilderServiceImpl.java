package liberty.capstone.process.qr;

import liberty.capstone.process.config.AlottaProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@ConfigurationProperties("alotta-properties.backend")
public class QRCodeBuilderServiceImpl implements QRCodeBuilderService {
    private static final String PARAMS = "/userId/%s/coupons/%s/redeem";
    private final AlottaProperties properties;
    @Override
    public QRCodeRequest buildQRCodeRequest(final String userId, final String couponId) {
        final QRCodeRequest request = new QRCodeRequest();
        request.setQr_code_text(properties.getBackendUrl() + String.format(PARAMS, userId, couponId));
        return request;
    }
}
