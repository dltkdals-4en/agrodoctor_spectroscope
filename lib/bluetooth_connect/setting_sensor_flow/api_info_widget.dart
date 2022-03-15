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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NORMALGAP)),
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'api 정보',
                    style: makeTextStyle(16, AppColors.black, 'medium'),
                  ),
                  // SizedBox(
                  //   width: 16,
                  //   height: 16,
                  //   child: IconButton(onPressed: () {
                  //
                  //   }, icon: Icon(Icons.settings),
                  //   padding: EdgeInsets.zero,
                  //   iconSize: 16,),
                  // )
                  SizedBox(
                    height: 25,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,

                      ),
                      child: Text('변경하기', style: makeTextStyle(16, AppColors.lightPrimary),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApiSettingPage(),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: AppColors.lightPrimary,
            ),
            Text('버튼 1 : ${provider.apiDataList[0].trim()}'),
            SizedBox(
              height: SMALLGAP,
            ),

            Text('버튼 2 : ${provider.apiDataList[1].trim()}'),
            SizedBox(
              height: SMALLGAP,
            ),
            Text('버튼 3 : ${provider.apiDataList[2].trim()}'),
            // ListView.separated(
            //
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: provider.apiDataList.length,
            //   itemBuilder: (context, index) {
            //     return Text('${provider.apiDataList[index].trim()}');
            //   },
            //   separatorBuilder: (context, index) {
            //     return Divider(
            //       color: AppColors.lightPrimary,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
