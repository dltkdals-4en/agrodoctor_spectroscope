// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_widget.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:ctgformanager/providers/protocol_provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BleProvider>(
          create: (_) => BleProvider(),
        ),
        ChangeNotifierProvider<ProtocolProvider>(
          create: (_) => ProtocolProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(805.3, 384.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            color: Colors.lightBlue,
            home: HomePage(),
            theme: ThemeData(
              fontFamily: 'NotoSansKR',
              textTheme: TextTheme(
                headline6: makeTextStyle(20, AppColors.black, 'bold'),
                subtitle1: makeTextStyle(16, AppColors.black, 'bold'),
              ),
              appBarTheme: AppBarTheme(
                  centerTitle: true,
                  toolbarTextStyle: makeTextStyle(20, AppColors.black, 'bold'),
                  color: AppColors.white,
                  titleTextStyle: makeTextStyle(20, AppColors.black, 'bold'),
                  iconTheme: IconThemeData(
                    color: AppColors.black,
                  ),
                  elevation: 0),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.lightPrimary,
                  textStyle: makeTextStyle(16, AppColors.white, 'bold'),
                ),
              ),
              listTileTheme: ListTileThemeData(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: NORMALGAP, vertical: SMALLGAP),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SMALLGAP),
                ),
                tileColor: AppColors.white,
                textColor: AppColors.black,
              ),
            ),
          );
        });
  }
}
