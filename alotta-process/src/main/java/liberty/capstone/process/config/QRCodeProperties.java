package liberty.capstone.process.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
@ConfigurationProperties("qr-code-properties")
public class QRCodeProperties {
    private String frameName;
    private Long imageHeight;
    private Long imageWidth;
    private String imageFormat;
    private String backgroundColor;
    private String foregroundColor;
    private String markerColor;
    private String markerTemplate;
}
