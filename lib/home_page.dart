import 'package:ctgformanager/blue_app.dart';
import 'package:ctgformanager/blue_case.dart';
import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/no_item_page.dart';
import 'package:ctgformanager/bluetooth_connect/test_wifi.dart';
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
                          builder: (context) => FlutterWifiIoT(),
                        ));
                  },
                  child: Text('test wifi'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await blueProvider.getPairingList();
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
