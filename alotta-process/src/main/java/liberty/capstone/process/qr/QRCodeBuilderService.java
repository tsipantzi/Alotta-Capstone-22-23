package liberty.capstone.process.qr;

public interface QRCodeBuilderService {
    String buildRedeemUrl(String userId, String couponId);
}
