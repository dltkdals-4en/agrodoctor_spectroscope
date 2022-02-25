import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'blue_serial_provider.dart';

class ArgsSettingProvider with ChangeNotifier {


 
  setUrl() {}

  getAux() {
    BlueSerialProvider().sendData('\$getAuxInfo();');
  }

  getUrl() {
    BlueSerialProvider().sendData('\$getUrlInfo();');
  }

  getWifi() {}
  
  Future getInfo(BluetoothDevice device) async{
    getAux();
    // getUrl();
  }
}
