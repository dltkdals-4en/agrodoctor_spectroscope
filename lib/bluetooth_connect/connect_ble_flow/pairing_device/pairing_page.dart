import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/connect_wifi_flow/check_wifi_setting_page.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/find_ble/find_ble_page.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/pairing_device/pairing_device_widget.dart';
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
            onPressed: () {
                provider.getPairingList();
            },
            icon: Icon(Icons.replay),
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
                  style: makeTextStyle(18, AppColors.black, 'medium'),
                  children: [
                    TextSpan(text: '현재 연결된 CO:AIR 기기는 총 '),
                    TextSpan(
                        text: '${provider.pairingDevices.length}',
                        style:
                            makeTextStyle(18, AppColors.lightPrimary, 'bold')),
                    TextSpan(text: '기에요.'),
                    TextSpan(
                      text: '\n(추가 기기를 등록하고 싶으시다면 우측 상단의 기기찾기 버튼을 클릭해주세요.)',
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
                itemCount: provider.pairingDevices.length+1,
                itemBuilder: (context, index) {
                  if(index == provider.pairingDevices.length){
                    return ListTile(
                      onTap: () {
                        provider.findBLeDivices();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindBlePage(),
                            ));
                      },
                      title: Text('기기 추가하기'),
                      leading: Icon(Icons.add),
                    );
                  }else {
                    return PairingDeviceWidget(provider.pairingDevices[index]);
                  }
                },
              ),
            ),
          ),
          Container(
            width: size.width,
            height: BUTTONHEIGHT,
            child: ElevatedButton(
                onPressed: () async {
                  await provider.checkWifiEnabled();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckWifiSettingPage(),
                      ));
                },
                child: Text('다음 단계')),
          )
        ],
      ),
    );
  }
}
