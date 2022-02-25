import 'dart:async';
import 'dart:ui';

import 'package:ctgformanager/bluetoothConnect/blue_serial_provider.dart';

import 'package:ctgformanager/bluetoothConnect/sensor_setting_screen.dart';
import 'package:ctgformanager/contstants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import 'bluetooth_list_tile.dart';

class FindBluetooth extends StatefulWidget {
  final bool start;

  const FindBluetooth({this.start = true});

  @override
  _FindBluetoothState createState() => _FindBluetoothState();
}

class _FindBluetoothState extends State<FindBluetooth> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _FindBluetoothState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<BlueSerialProvider>(context, listen: false).findBlue();
    });
    // isDiscovering = widget.start;
    // if (isDiscovering) {
    //   _startDiscovery();
    // }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final existingIndex = results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0) {
          results[existingIndex] = r;
        } else {
          var deviceName = (r.device.name != null) ? r.device.name : '';
          if (deviceName!.contains('fourenIoT')) {
            results.add(r);
          }
        }
      });
    });

    _streamSubscription!.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var blueData = Provider.of<BlueSerialProvider>(context);
    var size = MediaQuery.of(context).size;
    print(blueData.isDiscovering);
    // provider.findBlue();
    return Scaffold(
      appBar: AppBar(
        title: Text('블루투스 관리'),
        actions: [
          IconButton(
              onPressed: () {
                blueData.refindBlue();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 100,
            child: blueData.isDiscovering
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('연동 가능한 블루투스를 찾는 중이에요.'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text.rich(TextSpan(
                      text: '${blueData.results.length}',
                      style: TextStyle(
                          color: CoColor.coPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      children: [
                        TextSpan(
                          text: '개의 기기를 \n관리할 수 있어요.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    )),
                  ),
          ),
          blueData.isDiscovering
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: ListView.builder(
                    itemCount: blueData.results.length,
                    itemBuilder: (context, index) {
                      BluetoothDiscoveryResult result = blueData.results[index];
                      final device = result.device;

                      return Card(
                        elevation: 2,
                        child: BluetoothListTile(
                          device: device,
                          rssi: result.rssi,
                          onTap: () {
                            if (device.isBonded) {
                              switch (device.isConnected) {
                                case true:
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (context) =>
                                            SensorSettingScreen(device),
                                      ))
                                      .then((value) => blueData.sendListData());
                                  break;
                                case false:
                                  blueData.connectBlue(device, context);

                                  break;
                              }
                            } else {
                              blueData.pairingBlue(device, result, context);
                            }
                          },
                          onLongPress: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => SettingSensor(),
                            // ));
                          },
                        ),
                      );
                    },
                  ),
                ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => SettingSensor(),
          //       ));
          //     },
          //     child: Text('센서 세팅하기'))
        ],
      ),
    );
  }
}
