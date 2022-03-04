import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_screen.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindBlePage extends StatelessWidget {
  const FindBlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<BlueProvider>(context);
    print(provider.bleDiscovering);
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
          Container(
            width: size.width,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(NORMALGAP),
              child: (provider.bleDiscovering == true)
                  ? Text(
                      '연동 가능한 CO:AIR 기기를 찾는 중이에요.\n잠시 기다려주세요.',
                      style: makeTextStyle(16, AppColors.black, 'medium'),
                    )
                  : Text.rich(
                      TextSpan(
                        text: '${provider.bleDevices.length}',
                        style:
                            makeTextStyle(16, AppColors.lightPrimary, 'bold'),
                        children: [
                          TextSpan(
                            text: '개의 CO:AIR 기기를 찾았어요.',
                            style: makeTextStyle(16, AppColors.black, 'medium'),
                          )
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: SMALLGAP,
          ),
          (provider.bleDiscovering == true)
              ? LoadingScreen()
              : Expanded(
                  child: ListView.separated(
                    itemCount: provider.bleDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${provider.bleDevices[index].device.name ?? '알 수 없는 기기'}'),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: NORMALGAP,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
