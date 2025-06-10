package com.share.payment.domain;

import com.share.common.core.web.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Schema(description = "PaymentInfo")
public class PaymentInfo extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Schema(description = "用户id")
    private Long userId;

    @Schema(description = "订单号")
    private String orderNo;

    @Schema(description = "付款方式：1-微信")
    private Integer payWay;

    @Schema(description = "交易编号（微信或支付）")
    private String transactionId;

    @Schema(description = "支付金额")
    private BigDecimal amount;

    @Schema(description = "交易内容")
    private String content;

    @Schema(description = "支付状态：0-未支付 1-已支付 -1-关闭交易")
    private Integer paymentStatus;

    @Schema(description = "回调时间")
    private Date callbackTime;

    @Schema(description = "回调信息")
    private String callbackContent;

}
