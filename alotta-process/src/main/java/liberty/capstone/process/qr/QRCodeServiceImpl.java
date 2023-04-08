package liberty.capstone.process.qr;

import liberty.capstone.process.config.AlottaProperties;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class QRCodeServiceImpl implements QRCodeService {
    private final WebClient client;

    public QRCodeServiceImpl(final AlottaProperties properties) {
        client = WebClient.create(properties.getQrApiUrl() + properties.getQrApiToken());
    }

    @Override
    public byte[] getQRCode(final QRCodeRequest request) {
        return client.post()
                .headers(headers -> headers.setContentType(MediaType.APPLICATION_JSON))
                .body(Mono.just(request), QRCodeRequest.class)
                .retrieve()
                .bodyToMono(byte[].class)
                .block();
    }
}
