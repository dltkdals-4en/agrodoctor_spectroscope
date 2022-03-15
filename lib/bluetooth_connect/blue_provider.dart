import 'dart:convert';
import 'dart:typed_data';

import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_iot/wifi_iot.dart';

class BlueProvider with ChangeNotifier {
  FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> pairingDevices = [];
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
  List<bool> wifiCheck = [];
  FToast? fToast;
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
  List<String> resultDataString = [];
  List<String> apiDataList = [];
  List<String> wifiDataList = [];
  List<String> fanSpeedList = [];
  bool settingComplete = false;
  TextEditingController? btn1TextController;
  TextEditingController? btn2TextController;
  TextEditingController? btn3TextController;
  List<TextEditingController> apiSettingTextControllerList = [];

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

  void resetBleDevices() {
    bleDiscovering = true;
    notifyListeners();
    bleDevices.clear();
    findBLeDivices();
  }

  Future<void> getPairingList() async {
    serial.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      pairingDevices = bondedDevices
          .where((element) => element.name!.contains('fouren'))
          .toList();
      print(pairingDevices);
      notifyListeners();
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

  setWifiSsid(String s) async {
    wifiCheck.clear();
    await getWifiList().then((value) => value.forEach((element) {
          print(element.ssid);
          wifiCheck.add(element.ssid!.contains(s));
        }));
    print(wifiCheck);
    if (wifiCheck.contains(true)) wifiSsid = s;
    notifyListeners();
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

  bool checkWifiConnected() {
    WiFiForIoTPlugin.isConnected().then((value) {
      wifiConnected = value;
    });
    if (wifiConnected) setWifiSetting();
    print(wifiConnected);
    notifyListeners();
    return wifiConnected;
  }

  check() {
    WiFiForIoTPlugin.isConnected().then((value) {
      wifiConnected = value;
      notifyListeners();
    });
  }

  Future<void> connectWifi(String bssid) async {
    wifiSspw = wifiTextController.text;
    print('$wifiSsid + $wifiSspw + $bssid');
    await WiFiForIoTPlugin.connect(wifiSsid,
            bssid: bssid,
            password: wifiSspw,
            security: NetworkSecurity.WPA,
            isHidden: true)
        .whenComplete(() {
      checkWifiConnected();
    });
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
      connection!.input!.listen((event) {
        _onDataReceived(event);
      });
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
    splitDataString(dataString);
    return dataString;
    int index = buffer.indexOf(13);
  }

  sendListData() {
    for (var value in listStr) {
      sendData(value);
    }
  }

  String setBondedText(bool isBonded) {
    return (isBonded) ? '페어링 됨' : '페어링 안됨';
  }

  Future<void> devicePairing() async {
    for (var value in bleDevices) {
      if (!value.device.isBonded)
        await serial.bondDeviceAtAddress(value.device.address);
      notifyListeners();
    }
  }

  splitDataString(String s) async {
    var result = s.split(';');
    print(result);
    for (var i = 0; i < result.length - 1; i++) {
      var identify = result[i].substring(0, 4);
      var data = result[i].substring(5, result[i].length - 1);
      print(data);
      switch (identify) {
        case '\$103':
          apiDataList = data.split(',');
          notifyListeners();
          break;
        case '\$102':
          wifiDataList = data.split(',');
          notifyListeners();
          break;
        case '\$104':
          fanSpeedList = data.split(',');
          notifyListeners();
          break;
      }
    }
    if (apiDataList.isNotEmpty) settingComplete = true;
    notifyListeners();
  }

  void customToast(size, context, String s) {
    var inputText = s;

    fToast = FToast();
    fToast?.init(context);
    Widget toast = Container(
      width: size.width - NORMALGAP * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkGrey,
      ),
      height: BUTTONHEIGHT,
      child: Center(
        child: Text(
          inputText,
          style: makeTextStyle(16, AppColors.white, 'bold'),
        ),
      ),
    );
    fToast!.showToast(
      child: toast,
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          bottom: 120,
          left: 20,
        );
      },
    );
  }
}
