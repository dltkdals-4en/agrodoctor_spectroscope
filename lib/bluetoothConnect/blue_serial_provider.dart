import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ctgformanager/bluetoothConnect/sensor_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueSerialProvider with ChangeNotifier {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  BluetoothConnection? connection;
  bool isDiscovering = true;
  String ExplainText = '';
  bool isConnecting = true;

  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;

  String wifiSsid = 'no Data';
  String wifiSspw = 'no Data';
  String deviceName = 'no Data';
  int fan1 = 0;
  int fan2 = 0;
  int fan3 = 0;
  List<int> fanSpeedList = [0, 0, 0];
  List<String> urlStringList = [
    'https://www.4en.co.kr1',
    'https://www.4en.co.kr2',
    'https://www.4en.co.kr3'
  ];
  String url1 = 'https://www.4en.co.kr1';
  String url2 = 'https://www.4en.co.kr2';
  String url3 = 'https://www.4en.co.kr3';
  List<String> listStr = [
    '\$getAuxInfo();',
    '\$getWifiInfo();',
    '\$getUrlInfo();',

  ];

  findBlue() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      final existingIndex = results
          .indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        results[existingIndex] = r;
        notifyListeners();
      } else {
        var deviceName = (r.device.name != null) ? r.device.name : '';
        if (deviceName!.contains('fourenIoT')) {
          results.add(r);
          notifyListeners();
        }
      }
    });

    _streamSubscription!.onDone(() {
      isDiscovering = false;
      notifyListeners();
    });
  }

  refindBlue() {
    results.clear();
    isDiscovering = true;
    findBlue();
  }

  void pairingBlue(BluetoothDevice device, BluetoothDiscoveryResult result,
      BuildContext context) async {
    final address = device.address;
    try {
      bool bonded = false;
      if (device.isBonded) {
        print('${device.address} 등록 해제 중');
        await FlutterBluetoothSerial.instance
            .removeDeviceBondWithAddress(address);
        print('${device.address} 등록 해제 성공');

        notifyListeners();
      } else {
        print('Bonding with ${device.address}...');
        bonded = (await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(address))!;
        print('${device.address} 등록 ${bonded ? '성공' : '실패'}.');
        connectBlue(device, context);
        notifyListeners();
      }

      results[results.indexOf(result)] = BluetoothDiscoveryResult(
          device: BluetoothDevice(
            name: device.name ?? '',
            address: address,
            type: device.type,
            bondState:
                bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
          ),
          rssi: result.rssi);
      notifyListeners();
    } catch (ex) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('등록 중 오류 발생'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new TextButton(
                child: new Text("닫기"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      notifyListeners();
    }
  }

  connectBlue(BluetoothDevice device, BuildContext context) {
    BluetoothConnection.toAddress(device.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;

      isConnecting = false;
      isDisconnecting = false;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SensorSettingScreen(device),
      ));
      notifyListeners();

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    print(data);
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
    int index = buffer.indexOf(13);
    if (dataString.isNotEmpty) splitData(dataString);
  }

  Future sendData(String str) async {
    String sendStr = '$str\r\n';

    print(sendStr);
    var i = Uint8List.fromList(utf8.encode(sendStr));
    print(i);
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

  sendListData() {
    print(listStr.length);
    for (var value in listStr) {
      sendData(value);
    }
  }

  void getBlueInfo() async {
    if (connection!.output != null) {}
  }

  setWifi(String ssid, String sspw) {
    wifiSsid = ssid;
    wifiSspw = sspw;
    notifyListeners();
  }

  setAux(List urlList) {
    for (int i = 0; i < urlList.length; i++) {
      fanSpeedList[i] = urlList[i]['selected'];
      if (urlList[i]['url'].text.isNotEmpty)
        urlStringList[i] = urlList[i]['url'].text;
    }
    sendData(
        '\$setAuxInfo(${fanSpeedList.toString().substring(1, fanSpeedList.toString().length - 1)});');
    sendData(
        '\$setUrlInfo(${urlStringList.toString().substring(1, urlStringList.toString().length - 1)});');
    notifyListeners();
  }

  splitData(String dataString) {
    List<String> dataList = dataString.split(';');
    dataList.removeWhere((element) => element.isEmpty);
    print(dataList);
    for (var value in dataList) {
      var subStr = value.substring(5, value.length - 1);
      if (value.contains('\$104')) {
        var list = subStr.split(',');
        fanSpeedList.clear();
        for (var value in list) {
          fanSpeedList.add(int.parse(value));
          notifyListeners();
        }
      } else if (value.contains('\$103')) {
        var list = subStr.split(',');
        urlStringList.clear();
        urlStringList = list;
        notifyListeners();
      } else if (value.contains('\$102')) {
        var list = subStr.split(',');
        wifiSsid = list[0];
        wifiSspw = list[1];
        notifyListeners();
      }else {
        print('error');
      }
    }
  }
}
