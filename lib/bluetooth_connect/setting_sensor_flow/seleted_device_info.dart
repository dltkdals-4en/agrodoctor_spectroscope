import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SelectedDeviceInfo extends StatelessWidget {
  const SelectedDeviceInfo(this.pairingDevice, {Key? key}) : super(key: key);

  final BluetoothDevice pairingDevice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NORMALGAP)),
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기기 정보',
                style: makeTextStyle(18, AppColors.black, 'bold'),
              ),
              Divider(
                color: AppColors.lightPrimary,
              ),
              Row(
                children: [
                  Text(
                    '${pairingDevice.name}',
                    style: makeTextStyle(18, AppColors.black, 'bold'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
