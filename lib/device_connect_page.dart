import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:ctgformanager/providers/gsheets_provider.dart';
import 'package:ctgformanager/providers/protocol_provider.dart';
import 'package:ctgformanager/providers/setting_page_ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:provider/provider.dart';

class DeviceConnectPage extends StatelessWidget {
  const DeviceConnectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    var gsheets = Provider.of<GsheetsProvider>(context);
    var prProvider = Provider.of<ProtocolProvider>(context);
    var size = MediaQuery.of(context).size;
    BluetoothDevice device = bleProvider.selectDevice!;
    print(bleProvider.outputText);
    prProvider.setBleConnectedText(bleProvider.bleConnected);

    return Scaffold(
      appBar: AppBar(
        title: Text('${device.name}'),
        leading: BackButton(
          onPressed: () {
            bleProvider.connection?.dispose();
            bleProvider.connection = null;
            bleProvider.bleConnected = false;
            Navigator.maybePop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              gsheets.insertData(prProvider.inputText, bleProvider.outputText);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NORMALGAP),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${prProvider.bleConnected}',
                    style: prProvider.bleConnectedStyle,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await bleProvider.connecteBle();
                    },
                    child: Text('기기 연결하기'),
                  ),
                ],
              ),
              Container(
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.lightPrimary),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('입력값 : ${prProvider.inputText}'),
                      Text(
                          '데이터 길이 : ${bleProvider.getOutputData().split(',').length}'),
                      Text('데이터 값 : \n ${bleProvider.getOutputData()}'),
                      // Text(bleProvider.getOutputData()),
                    ],
                  ),
                ),
              ),
              NorH,
              Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        bleProvider.sendData('\$preOperation()\r\n');
                        prProvider.inputProtocol('\$preOperation()\r\n');
                      },
                      child: Text('preOperation'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bleProvider.sendData('\$endOperation()\r\n');
                        prProvider.inputProtocol('\$endOperation()\r\n');
                      },
                      child: Text('endOperation'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bleProvider.sendData('\$connectSensor()\r\n');
                        prProvider.inputProtocol('\$connectSensor()\r\n');
                      },
                      child: Text('connectSensor'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bleProvider.sendData('\$getSpectrumData()\r\n');
                        prProvider.inputProtocol('\$getSpectrumSensor()\r\n');
                      },
                      child: Text('getSpectrum'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bleProvider.sendData('\$getXyzData()\r\n');
                        prProvider.inputProtocol('\$getXyzData()\r\n');
                      },
                      child: Text('getXYZ'),
                    ),

                    // SmH,
                    // Container(
                    //   width: size.width,
                    //   child: TextField(
                    //     controller: prProvider.anyProtocol,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: AppColors.lightPrimary,
                    //           width: 2,
                    //         ),
                    //       ),
                    //       focusColor: AppColors.lightPrimary,
                    //     ),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     prProvider.inputProtocol(
                    //         '\$${prProvider.anyProtocol.value.text}');
                    //     bleProvider
                    //         .sendData('\$${prProvider.anyProtocol.value.text}');
                    //   },
                    //   child: Text('any protocol'),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
