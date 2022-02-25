import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/pairing_device_widget.dart';
import 'package:ctgformanager/bluetooth_connect/test_wifi.dart';
import 'package:ctgformanager/bluetooth_connect/wifi_connect_page.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PairingPage extends StatelessWidget {
  const PairingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('기기 연결하기'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.replay_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(NORMALGAP),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: makeTextStyle(16, AppColors.black, 'medium'),
                  children: [
                    TextSpan(text: '현재 연결된 CO:AIR 기기는 총 '),
                    TextSpan(
                        text: '${provider.paringDevices.length}',
                        style:
                            makeTextStyle(16, AppColors.lightPrimary, 'bold')),
                    TextSpan(text: '기에요.'),
                    TextSpan(
                      text: '\n(추가 기기를 등록하고 싶으시다면 우측 상단의 새로고침 버튼을 클릭해주세요.)',
                      style: makeTextStyle(
                        16,
                        AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: SMALLGAP,
          ),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: ListView.builder(
                itemCount: provider.paringDevices.length,
                itemBuilder: (context, index) {
                  return PairingDeviceWidget(provider.paringDevices[index]);
                },
              ),
            ),
          ),
          Container(
            width: size.width,
            height: BUTTONHEIGHT,
            child: ElevatedButton(onPressed: () {
              provider.getWifiList();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WifiConnectPage(),
                  ));
            }, child: Text('다음 단계')),
          )
        ],
      ),
    );
  }
}
