package liberty.capstone.process.qr;

public interface QRCodeService {
    byte[] getQRCode(final QRCodeRequest request);
}
