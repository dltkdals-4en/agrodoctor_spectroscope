// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ctgformanager/bluetoothConnect/blue_serial_provider.dart';
import 'package:ctgformanager/bluetoothConnect/args_setting_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bluetooth_connect/blue_provider.dart';
import 'home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ArgsSettingProvider>(
          create: (_) => ArgsSettingProvider(),
        ),
        ChangeNotifierProvider<BlueSerialProvider>(
          create: (_) => BlueSerialProvider(),
        ),
        ChangeNotifierProvider<BlueProvider>(
          create: (_) => BlueProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 18),
        ),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            toolbarTextStyle: makeTextStyle(18, AppColors.black, 'bold'),
            color: AppColors.white,
            titleTextStyle:
                // TextStyle(fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold)
                makeTextStyle(18, AppColors.black, 'bold'),
            iconTheme: IconThemeData(
              color: AppColors.black,
            ),
            elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.lightPrimary,
            textStyle: makeTextStyle(18, AppColors.white, 'bold'),
          ),
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
    );
  }
}
