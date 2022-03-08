import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindBleHeaderWidget extends StatelessWidget {
  const FindBleHeaderWidget({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<BlueProvider>(context);
    return Container(
      width: size.width,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: (provider.bleDiscovering == true)
            ? Text(
          '연동 가능한 CO:AIR 기기를 찾는 중이에요.\n잠시 기다려주세요.',
          style: makeTextStyle(18, AppColors.black, 'medium'),
        )
            : Text.rich(
          TextSpan(
            text: '${provider.bleDevices.length}',
            style:
            makeTextStyle(18, AppColors.lightPrimary, 'bold'),
            children: [
              TextSpan(
                text: '개의 CO:AIR 기기를 찾았어요.',
                style: makeTextStyle(18, AppColors.black, 'medium'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
