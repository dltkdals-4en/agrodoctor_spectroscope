import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/setting_args_page.dart';
import 'package:ctgformanager/bluetooth_connect/wifi_complete_page.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiInputInfo extends StatelessWidget {
  const WifiInputInfo(
    this.wifiData, {
    Key? key,
  }) : super(key: key);
  final WifiNetwork wifiData;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('${provider.wifiSsid}'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BIGRADIUS),
              color: AppColors.white,
            ),
            padding: EdgeInsets.all(NORMALGAP),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '비밀번호',
                  style: makeTextStyle(12, AppColors.lightPrimary, 'regular'),
                ),
                TextField(
                  controller: provider.wifiTextController,
                  autofocus: true,
                  obscureText: provider.wifiObscure,
                  cursorColor: AppColors.lightPrimary,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    focusColor: AppColors.lightPrimary,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightPrimary,
                        width: 2,
                      ),
                    ),
                    suffix: IconButton(
                      icon: provider.wifiObscureIcon,
                      color: AppColors.lightPrimary,
                      onPressed: () {
                        provider.setWifiObscure();
                      },
                    ),
                  ),
                ),
                Container(
                  width: size.width - NORMALGAP * 2,
                  height: BUTTONHEIGHT,
                  child: ElevatedButton(
                    onPressed: () async {
                      await provider.connectWifi(wifiData.bssid!);
                      if (provider.wifiConnected == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WifiComplete(),
                            ),
                            (route) => false);
                      } else {
                        print('no');
                      }
                    },
                    child: Text('와이파이 연결하기'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
