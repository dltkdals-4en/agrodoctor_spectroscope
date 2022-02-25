import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:wifi_iot/wifi_iot.dart';

class BlueProvider with ChangeNotifier {
  FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> paringDevices = [];
  List<WifiNetwork> wifiList = [];

  Future<void> getPairingList() async {
    serial.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      paringDevices = bondedDevices
          .where((element) => element.name!.contains('fouren'))
          .toList();
      print(paringDevices);
    });
  }

  Future<List<WifiNetwork>> getWifiList() async {
    try {
      wifiList = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      wifiList = <WifiNetwork>[];
      print('no wifiList');
    }

    return wifiList;
  }
}
