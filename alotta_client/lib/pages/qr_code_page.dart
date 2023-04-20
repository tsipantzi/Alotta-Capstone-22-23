import 'package:alotta_client/assets/colors/colors.dart';
import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../assets/services/api_constants.dart';

class QrCodePage extends StatelessWidget {
  final int userId;
  final int couponId;
  final CustomerInventoryService customerInventoryService =
      CustomerInventoryService();

  QrCodePage(this.userId, this.couponId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl:
            ApiConstants.getQRCodeForCustomerAndCouponUrl(userId, couponId),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            const Icon(color: primaryCream, Icons.error, size: 200),
      ),
    );
  }
}
