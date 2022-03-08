import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/find_ble/find_ble_page.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoItemPage extends StatelessWidget {
  const NoItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo/copick_GRBL.png',
          fit: BoxFit.cover,
          height: 22,
        ),
        actions: [
          Image.asset(
            'assets/images/icon/addBtn.png',
            color: AppColors.black,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / 2,
              height: size.width / 2,
              child: Image.asset(
                'assets/images/icon/noData.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: NORMALGAP,
            ),
            SizedBox(
              width: size.width / 2,
              height: BUTTONHEIGHT,
              child: ElevatedButton(
                onPressed: () {
                  provider.findBLeDivices();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FindBlePage(),
                      ));
                },
                child: Text(
                  '새 기기 추가하기',
                  style: TextStyle(fontFamily: 'NotoSansKR'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
