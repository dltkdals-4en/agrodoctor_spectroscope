import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistreingShopWidget extends StatelessWidget {
  const RegistreingShopWidget({Key? key}) : super(key: key);

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
              Text(
                '등록 매장 정보',
                style: makeTextStyle(16, AppColors.black, 'medium'),
              ),
              Divider(
                color: AppColors.lightPrimary,
              ),
              Row(
                children: [
                  Text('등록된 매장이 없습니다.'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
