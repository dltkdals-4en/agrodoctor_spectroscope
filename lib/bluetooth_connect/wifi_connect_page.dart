import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiConnectPage extends StatelessWidget {
  const WifiConnectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    print(provider.wifiList);
    return Scaffold(
      appBar: AppBar(
        title: Text('와이파이 연결하기'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('와이파이 연결을 켜주세요'),
          ),
          Expanded(child: ListView.builder(
            itemCount: provider.wifiList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${provider.wifiList[index].ssid}'),
              );
            },
          ))
        ],
      ),
    );
  }
}
