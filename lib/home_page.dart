import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/no_item_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bluetooth_connect/connect_ble_flow/pairing_device/pairing_page.dart';
import 'bluetooth_connect/test_wifi.dart';

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
                            builder: (context) =>
                                (blueProvider.pairingDevices.isEmpty)
                                    ? NoItemPage()
                                    : PairingPage(),
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
