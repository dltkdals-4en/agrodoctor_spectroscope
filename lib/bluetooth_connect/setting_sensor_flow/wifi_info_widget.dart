import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class WifiInfoWidget extends StatelessWidget {
  const WifiInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NORMALGAP)),
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Wifi 정보',
                      style: makeTextStyle(16, AppColors.black, 'medium'),
                    ),
                    // SizedBox(
                    //   height: 25,
                    //   child: TextButton(
                    //     style: TextButton.styleFrom(
                    //       padding: EdgeInsets.zero,
                    //
                    //     ),
                    //     child: Text('상태 체크', style: makeTextStyle(16, AppColors.lightPrimary),),
                    //     onPressed: () {
                    //         provider.check();
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),

              Divider(
                color: AppColors.lightPrimary,
              ),
              Text('와이파이 ssid : ${provider.wifiSsid}'),
              SizedBox(
                height: SMALLGAP,
              ),
              Text('와이파이 sspw: ${provider.wifiSspw}'),
            ],
          ),
        ),
      ),
    );
  }
}
