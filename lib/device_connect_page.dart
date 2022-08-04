import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class DeviceConnectPage extends StatelessWidget {
  const DeviceConnectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    var device = bleProvider.bleDevices[bleProvider.selectedIndex!].device;
    return Scaffold(
      appBar: AppBar(
        title: Text('기기 설정'),
      ),
      body: Container(
        child: Text('${device.name}'),
      ),
    );
  }
}
