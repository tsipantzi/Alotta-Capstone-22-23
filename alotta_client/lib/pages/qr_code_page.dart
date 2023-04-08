import 'package:flutter/material.dart';

import '../assets/services/api_constants.dart';

class QrCodePage extends StatelessWidget {
  final int userId;
  final int couponId;

  const QrCodePage(this.userId, this.couponId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        ApiConstants.getQRCodeForCustomerAndCouponUrl(userId, couponId),
      ),
    );
  }
}
