import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_screen.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import 'api_info_widget.dart';

class SettingArgsPage extends StatelessWidget {
  const SettingArgsPage(this.pairingDevice, {Key? key}) : super(key: key);

  final BluetoothDevice pairingDevice;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('기기 환경 설정'),
        leading: BackButton(
          onPressed: () {
            provider.connection?.dispose();
            provider.connection = null;
            Navigator.maybePop(context);
          },
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              provider.sendListData();
            },
            icon: Icon(Icons.replay),
          ),
        ],
      ),
      body: (provider.settingComplete)
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pairingDevice.name}',
                style: makeTextStyle(18, AppColors.black, 'bold'),
              ),
              SizedBox(
                height: NORMALGAP,
              ),
              Text(
                '매장 등록',
                style: makeTextStyle(16, AppColors.black, 'medium'),
              ),
              SizedBox(
                height: SMALLGAP,
              ),
              Text('등록하기'),
              SizedBox(
                height: NORMALGAP,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'wifi 정보',
                      style: makeTextStyle(16, AppColors.black, 'medium'),
                    ),
                    SizedBox(
                      height: SMALLGAP,
                    ),
                    Row(
                      children: [
                        Text('${provider.wifiSsid}'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: NORMALGAP,
              ),
              ApiInfoWidget(),
            ],
          )
          : LoadingScreen(),
    );
  }
}
