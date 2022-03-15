import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiSettingPage extends StatelessWidget {
  const ApiSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('api 정보 변경'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '수정하기',
              style: makeTextStyle(16, AppColors.lightPrimary, 'medium'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: ListView.separated(
          itemCount: provider.apiDataList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '버튼 ${index + 1} api 정보',
                  style: makeTextStyle(16, AppColors.black, 'bold'),
                ),
                SizedBox(
                  height: SMALLGAP,
                ),
                TextFormField(
                  controller: provider.btn1TextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteGrey,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lightPrimary, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkGrey, width: 2),
                    ),
                    hintText: '${provider.apiDataList[index]}',
                  ),
                  cursorColor: AppColors.lightPrimary,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: NORMALGAP,
            );
          },
        ),
      ),
    );
  }
}
