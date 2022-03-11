import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_setting_page.dart';

class ApiInfoWidget extends StatelessWidget {
  const ApiInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(SMALLGAP),
      ),
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'api 정보',
                  style: makeTextStyle(16, AppColors.black, 'medium'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,

                  ),
                  child: Text('변경하기'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApiSettingPage(),
                        ));
                  },
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: provider.apiDataList.length,
                itemBuilder: (context, index) {
                  return Text('${provider.apiDataList[index].trim()}');
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.lightPrimary,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           'api 정보',
      //           style: makeTextStyle(16, AppColors.black, 'medium'),
      //         ),
      //         IconButton(
      //           padding: EdgeInsets.zero,
      //           onPressed: () {
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => ApiSettingPage(),));
      //           },
      //           icon: Icon(Icons.settings,size: 16),
      //
      //         )
      //       ],
      //     ),
      //     SizedBox(
      //       height: SMALLGAP,
      //     ),
      //     Text('${provider.apiDataList[0].trim()}'),
      //     Text('${provider.apiDataList[1].trim()}'),
      //     Text('${provider.apiDataList[2].trim()}'),
      //   ],
      // ),
    );
  }
}
