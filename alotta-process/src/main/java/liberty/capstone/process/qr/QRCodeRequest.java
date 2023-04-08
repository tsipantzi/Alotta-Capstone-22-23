package liberty.capstone.process.qr;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;

@Data
@JsonSerialize
@SuppressWarnings({"MemberName", "MultipleStringLiterals", "PMD.FieldNamingConventions", "ConstantName",
        "PMD.AvoidDuplicateLiterals"})
public class QRCodeRequest {
    private static final String frame_name = "no-frame";
    private static final String image_format = "PNG";
    private static final String background_color = "#ffffff";
    private static final String foreground_color = "#eb7450";
    private static final String marker_right_inner_color = "#4d9f6b";
    private static final String marker_right_outer_color = "#4d9f6b";
    private static final String marker_left_inner_color = "#4d9f6b";
    private static final String marker_left_outer_color = "#4d9f6b";
    private static final String marker_bottom_inner_color = "#4d9f6b";
    private static final String marker_bottom_outer_color = "#4d9f6b";
    private static final String marker_left_template = "version13";
    private static final String marker_right_template = "version13";
    private static final String marker_bottom_template = "version13";
    private String qr_code_text;
}
