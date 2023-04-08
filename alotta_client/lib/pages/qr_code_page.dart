import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:flutter/material.dart';

class QrCodePage extends StatelessWidget {
  final int userId;
  final int couponId;
  final CustomerInventoryService customerInventoryService =
      CustomerInventoryService();

  QrCodePage(this.userId, this.couponId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: customerInventoryService.getQrCodeForCoupon(userId, couponId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!, fit: BoxFit.cover);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }
}
