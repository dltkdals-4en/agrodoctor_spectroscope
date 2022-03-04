import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/wifi_listtile_widget.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiListPage extends StatelessWidget {
  const WifiListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: provider.getWifiList(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(NORMALGAP),
                  child:
                      Text('현재 CO:AIR는 5G를 지원하고 있지 않습니다. \nwifi 연결 시 유의해주세요.'),
                ),
                color: AppColors.white,
              ),
              SizedBox(
                height: SMALLGAP,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.wifiList.length,
                  itemBuilder: (context, index) {
                    return WifiListTileWidget(index);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: SMALLGAP,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
