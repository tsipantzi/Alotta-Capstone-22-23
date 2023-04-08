package liberty.capstone.process.config;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
@ConfigurationProperties("alotta-properties")
public class AlottaProperties {
    private String backendUrl;
    private String qrApiUrl;
    private String qrApiToken;
}
