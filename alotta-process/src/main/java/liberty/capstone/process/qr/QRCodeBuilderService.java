package liberty.capstone.process.qr;

public interface QRCodeBuilderService {
    QRCodeRequest buildQRCodeRequest(String userId, String couponId);
}
