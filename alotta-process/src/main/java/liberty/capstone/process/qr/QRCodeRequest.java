package liberty.capstone.process.qr;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import liberty.capstone.process.config.QRCodeProperties;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@JsonSerialize
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
public class QRCodeRequest {
    private String frameName;
    private String imageFormat;
    private Long imageHeight;
    private Long imageWidth;
    private String backgroundColor;
    private String foregroundColor;
    private String markerRightInnerColor;
    private String markerRightOuterColor;
    private String markerLeftInnerColor;
    private String markerLeftOuterColor;
    private String markerBottomInnerColor;
    private String markerBottomOuterColor;
    private String markerLeftTemplate;
    private String markerRightTemplate;
    private String markerBottomTemplate;
    private String qrCodeText;

    public QRCodeRequest(@NonNull QRCodeProperties properties, String qrCodeText) {
        this.frameName = properties.getFrameName();
        this.imageFormat = properties.getImageFormat();
        this.imageHeight = properties.getImageHeight();
        this.imageWidth = properties.getImageWidth();
        this.backgroundColor = properties.getBackgroundColor();
        this.foregroundColor = properties.getForegroundColor();
        this.markerRightInnerColor = properties.getMarkerColor();
        this.markerRightOuterColor = properties.getMarkerColor();
        this.markerLeftInnerColor = properties.getMarkerColor();
        this.markerLeftOuterColor = properties.getMarkerColor();
        this.markerBottomInnerColor = properties.getMarkerColor();
        this.markerBottomOuterColor = properties.getMarkerColor();
        this.markerLeftTemplate = properties.getMarkerTemplate();
        this.markerRightTemplate = properties.getMarkerTemplate();
        this.markerBottomTemplate = properties.getMarkerTemplate();
        this.qrCodeText = qrCodeText;
    }
}
