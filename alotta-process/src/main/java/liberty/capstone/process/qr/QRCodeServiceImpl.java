package liberty.capstone.process.qr;

import org.springframework.stereotype.Service;

@Service
public class QRCodeServiceImpl implements QRCodeService {
    @Override
    public byte[] getQRCode(final String url) {
        return new byte[0];
    }
}
