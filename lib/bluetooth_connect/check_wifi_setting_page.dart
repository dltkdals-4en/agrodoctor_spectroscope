import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/wifi_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckWifiSettingPage extends StatelessWidget {
  const CheckWifiSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wifi 연결하기'),
        actions: [
          IconButton(
            onPressed: () {
              provider.resetWifi();
            },
            icon: Icon(Icons.replay_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: provider.checkWifiEnabled(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            print(snapshot.data);
            return (snapshot.data== true)
                ? WifiListPage()
                : Column(
                    children: [
                      Text('wifi가 켜져있지 않아요.\n아래 버튼을 눌러 설정창 이동 후 wifi를 켜주세요.'),
                      ElevatedButton(
                          onPressed: () {
                            provider.enableWifi();
                          },
                          child: Text('wifi 설정하기'))
                    ],
                  );
          }
        },
      ),
    );
  }
}
