import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PairingDeviceWidget extends StatelessWidget {
  const PairingDeviceWidget(this.paringDevice, {Key? key}) : super(key: key);

  final BluetoothDevice paringDevice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(NORMALGAP),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${paringDevice.name}',
            style: makeTextStyle(16, AppColors.black, 'bold'),
          ),
          Text(
            '${paringDevice.address}',
            style: makeTextStyle(14, AppColors.blackGrey, 'regular'),
          ),
        ],

      ),
      trailing: (paringDevice.isConnected)?Text('연결됨'):Text('연결안됨'),
    );
  }
}
