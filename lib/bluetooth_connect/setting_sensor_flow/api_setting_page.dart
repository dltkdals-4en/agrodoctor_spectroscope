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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.red,
        ),
        child: Padding(
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.darkGrey, width: 2),
                      ),
                      hintText: '${provider.apiDataList[index]}',
                    ),
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
      ),
    );
  }
}
