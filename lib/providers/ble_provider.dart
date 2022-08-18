import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BleProvider with ChangeNotifier {
  FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> pairingDevices = [];
  List<BluetoothDiscoveryResult> bleDevices =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  BluetoothDevice? selectDevice;
  bool findPairingDevices = false;
  bool findBleDevices = false;
  BluetoothConnection? connection;
  bool bleConnected = false;
  int? selectedIndex;
  List<String> outputList = [];
  String outputText = "출력값이 없습니다.";

  void scanBle() {
    serial.startDiscovery().listen((event) {
      final existingIndex = bleDevices.indexWhere(
          (element) => element.device.address == event.device.address);
      if (existingIndex >= 0) {
        bleDevices[existingIndex] = event;
      } else {
        var deviceName =
            (event.device.name != null) ? event.device.name : '알 수 없는 기기';

        if (deviceName!.contains('AgroSPM')) {
          bleDevices.add(event);
        }
      }
    }).onDone(() {
      findBleDevices = true;
      print('END $findBleDevices');
      notifyListeners();
    });
  }

  Future<void> connecteBle() async {
    print('connectBle() : ${selectDevice!.isConnected}');
    if (!bleConnected) {
      await BluetoothConnection.toAddress(selectDevice!.address).then((value) {
        connection = value;

        bleConnected = value.isConnected;
        if (bleConnected == true) {
          // sendData(value);

          print(bleConnected);
          notifyListeners();
        } else {
          print('블루투스 연결 실패');
        }
        connection!.input!.listen((event) {
          _onDataReceived(event);
          // notifyListeners();
        });
      }).catchError((e) {

        print("error: $e");
      });
    } else {
      bleConnected = false;
      if (connection != null) {
        connection!.dispose();

        connection = null;
      }
      notifyListeners();
    }
  }

  Future<void> sendData(String str) async {
    outputList.clear();
    String sendStr = '$str\r\n';
    print('send $sendStr');
    var i = Uint8List.fromList(utf8.encode(sendStr));

    if (str.length > 0) {
      try {
        print('test');
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
    String dataString2 = String.fromCharCodes(data);
    print('data $data');
    print('buffer $buffer');
    print('dataS $dataString2');
    outputProtocol(dataString);

    return dataString;
    int index = buffer.indexOf(13);
  }

  int outputDataLength = 0;

  void outputProtocol(String str) {
    outputList.add(str);
    notifyListeners();
  }

  String getOutputData() {
    String data = '';
    outputList.forEach((element) {
      data += element;
    });

    outputDataLength = data.split(',').length;
    return data;
  }

  Future<void> getPairingList() async {
    await serial.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      pairingDevices = bondedDevices
          .where((element) => element.name!.contains('AgroSPM'))
          .toList();
    }).then((value) {
      findPairingDevices = true;
      notifyListeners();
    });
  }

  void initPairingDevices() {
    pairingDevices.clear();
    notifyListeners();
    getPairingList();
  }

  void initBleDevices() {
    bleDevices.clear();
    notifyListeners();
    scanBle();
  }

  Future<void> devicePairing(String address) async {
    await serial.bondDeviceAtAddress(address);
    notifyListeners();
  }

  void setSelectedDivice(BluetoothDevice device) {
    selectDevice = device;
    notifyListeners();
  }
}
