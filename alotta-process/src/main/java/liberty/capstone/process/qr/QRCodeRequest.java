package liberty.capstone.process.qr;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import edu.umd.cs.findbugs.annotations.SuppressFBWarnings;
import lombok.Data;

@Data
@JsonSerialize
@SuppressWarnings({"MemberName", "MultipleStringLiterals", "PMD.FieldNamingConventions", "ConstantName",
        "PMD.AvoidDuplicateLiterals", "PMD.FinalFieldCouldBeStatic", "PMD.UnnecessaryAnnotationValueElement"})
@SuppressFBWarnings(value = "RCN_REDUNDANT_NULLCHECK_OF_NONNULL_VALUE")
public class QRCodeRequest {
    private final String frame_name = "no-frame";
    private final String image_format = "PNG";
    private final String background_color = "#ffffff";
    private final String foreground_color = "#eb7450";
    private final String marker_right_inner_color = "#4d9f6b";
    private final String marker_right_outer_color = "#4d9f6b";
    private final String marker_left_inner_color = "#4d9f6b";
    private final String marker_left_outer_color = "#4d9f6b";
    private final String marker_bottom_inner_color = "#4d9f6b";
    private final String marker_bottom_outer_color = "#4d9f6b";
    private final String marker_left_template = "version13";
    private final String marker_right_template = "version13";
    private final String marker_bottom_template = "version13";
    private String qr_code_text;
}
