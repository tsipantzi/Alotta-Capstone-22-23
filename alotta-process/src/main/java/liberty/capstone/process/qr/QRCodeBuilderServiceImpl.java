package liberty.capstone.process.qr;

import liberty.capstone.process.config.AlottaProperties;
import liberty.capstone.process.config.QRCodeProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@ConfigurationProperties("alotta-properties.backend")
public class QRCodeBuilderServiceImpl implements QRCodeBuilderService {
    private static final String PARAMS = "/userId/%s/coupons/%s/redeem";
    private final AlottaProperties properties;
    private final QRCodeProperties qrCodeProperties;
    @Override
    public QRCodeRequest buildQRCodeRequest(final String userId, final String couponId) {
        return new QRCodeRequest(qrCodeProperties, getQrCodeText(userId, couponId));
    }

    private String getQrCodeText(final String userId, final String couponId) {
        return properties.getBackendUrl() + String.format(PARAMS, userId, couponId);
    }
}
