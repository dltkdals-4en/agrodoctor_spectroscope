import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_iot/wifi_iot.dart';

class BlueProvider with ChangeNotifier {
  FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> paringDevices = [];
  List<BluetoothDiscoveryResult> bleDevices =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  List<WifiNetwork> wifiList = [];
  BluetoothDevice? selectDevice;
  String wifiSsid = '';
  String wifiSspw = '';
  bool wifiEnabled = false;
  bool wifiConnected = false;
  bool bleDiscovering = true;
  bool bleConnected = false;
  bool wifiObscure = true;
  Icon wifiObscureIcon = Icon(Icons.visibility_off);
  NetworkSecurity default_security = NetworkSecurity.NONE;
  TextEditingController wifiTextController = TextEditingController();
  BluetoothConnection? connection;
  List<String> listStr = [
    '\$getAuxInfo();',
    '\$getWifiInfo();',
    '\$getUrlInfo();',
  ];

  void findBLeDivices() {
    serial.startDiscovery().listen((event) {
      final existingIndex = bleDevices.indexWhere(
          (element) => element.device.address == event.device.address);
      if (existingIndex >= 0) {
        bleDevices[existingIndex] = event;

      } else {
        var deviceName =
            (event.device.name != null) ? event.device.name : '알 수 없는 기기';
        if (deviceName!.contains('fourenIoT')) {
          bleDevices.add(event);
        }
      }
    }).onDone(() {
      bleDiscovering = false;
      notifyListeners();
    });
  }
  void resetBleDevices(){
    bleDiscovering = true;
    notifyListeners();
    bleDevices.clear();
    findBLeDivices();
  }

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

      wifiList.forEach((element) {
        print(
            '${element.ssid} / ${element.bssid} / ${element.capabilities} /${element.frequency}/${element.level}');
      });
      wifiList.removeWhere((element) => element.frequency! > 5000);
      print(wifiList);
    } on PlatformException {
      wifiList = <WifiNetwork>[];
      print('no wifiList');
    }
    return wifiList;
  }

  resetWifi() {
    wifiList.clear();
    getWifiList();
    notifyListeners();
  }

  setWifiSsid(String s) {
    wifiSsid = s;
  }

  void setWifiObscure() {
    if (wifiObscure == true) {
      wifiObscure = false;
      wifiObscureIcon = Icon(Icons.visibility);
    } else {
      wifiObscure = true;
      wifiObscureIcon = Icon(Icons.visibility_off);
    }
    notifyListeners();
  }

  Future<bool> checkWifiEnabled() async {
    await WiFiForIoTPlugin.isEnabled().then((value) {
      wifiEnabled = value;
    });
    print('wifi a : ${await WiFiForIoTPlugin.isConnected()}');
    print('wifi : $wifiEnabled');
    return wifiEnabled;
  }

  void enableWifi() {
    WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
  }

  Future<bool> checkWifiConnected() async {
    await WiFiForIoTPlugin.isConnected().then((value) {
      wifiConnected = value;
    });
    if (wifiConnected) setWifiSetting();
    print(wifiConnected);
    return wifiConnected;
  }

  Future<void> connectWifi(String bssid) async {
    wifiSspw = wifiTextController.text;
    print('$wifiSsid + $wifiSspw + $bssid');
    await WiFiForIoTPlugin.connect(wifiSsid,
            bssid: bssid,
            password: wifiSspw,
            security: NetworkSecurity.WPA,
            isHidden: true)
        .whenComplete(() => checkWifiConnected());
  }

  Future<void> setWifiSetting() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ssid', wifiSsid);
    await prefs.setString('sspw', wifiSspw);
  }

  void selectDeviceSetting(BluetoothDevice paringDevice) {
    selectDevice = paringDevice;
    connectSensor();
  }

  void connectSensor() {
    BluetoothConnection.toAddress(selectDevice!.address).then((value) {
      connection = value;
      bleConnected = value.isConnected;
      if (bleConnected == true) {
        sendListData();
      } else {
        print('블루투스 연결 실패');
      }
    });
  }

  Future sendData(String str) async {
    String sendStr = '$str\r\n';

    var i = Uint8List.fromList(utf8.encode(sendStr));

    if (str.length > 0) {
      try {
        connection!.output.add(i);
        await connection!.output.allSent;
      } catch (e) {
        print(e);
        // Ignore error, but notify state

      }
    }
  }

  receiveData() {
    connection!.input!.listen((event) {
      _onDataReceived(event);
    });
  }

  String _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);

    print(dataString);
    return dataString;
    int index = buffer.indexOf(13);
  }

  sendListData() {
    for (var value in listStr) {
      sendData(value);
      receiveData();
    }
  }
}
