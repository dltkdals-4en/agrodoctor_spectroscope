import 'package:ctgformanager/blue_app.dart';
import 'package:ctgformanager/blue_case.dart';
import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/no_item_page.dart';
import 'package:ctgformanager/registration/regist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bluetoothConnect/find_bluetooth.dart';
import 'bluetooth_connect/pairing_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var blueProvider = Provider.of<BlueProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.white10,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlueCase(),
                        ));
                  },
                  child: Text('모든 기기 스캔'),
                ),
                // ElevatedButton(onPressed: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => BlelibCase(),));
                // }, child: Text('FlutterBleLib'),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlueApp(),
                        ));
                  },
                  child: Text('Bluetooth Serial'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistScreen(),
                        ));
                  },
                  child: Text('모르는 기기 제외'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindBluetooth(),
                        ));
                  },
                  child: Text('블루투스 찾기'),
                ),
                ElevatedButton(
                    onPressed: () {
                      blueProvider.getPairingList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (blueProvider.paringDevices.isEmpty)?NoItemPage():PairingPage(),
                          ));
                    },
                    child: Text('BLE UI'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
