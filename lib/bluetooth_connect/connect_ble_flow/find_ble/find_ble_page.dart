import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/find_ble/widget/find_ble_header_widget.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/find_ble/widget/find_ble_listview_widget.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/pairing_device/pairing_page.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_screen.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/find_ble_listtile_widget.dart';

class FindBlePage extends StatelessWidget {
  const FindBlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<BlueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CO:AIR 기기 찾기'),
        actions: [
          IconButton(
            onPressed: () {
              provider.resetBleDevices();
            },
            icon: Icon(Icons.replay_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          FindBleHeaderWidget(),
          SizedBox(
            height: SMALLGAP,
          ),
          FindBleListViewWidget(),
          Visibility(
            visible: !provider.bleDiscovering,
            child: Container(
              width: size.width,
              height: BUTTONHEIGHT,
              child: ElevatedButton(
                onPressed: () async {
                  await provider
                      .devicePairing()
                      .whenComplete(() {
                        provider.getPairingList();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PairingPage(),
                          ),
                          (route) => false);});
                },
                child: Text('페어링하기'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
