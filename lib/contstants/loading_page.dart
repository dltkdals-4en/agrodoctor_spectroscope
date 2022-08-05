import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage(this.loadingText, {Key? key}) : super(key: key);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingWidget(),
          SmH,
          Text(
            '$loadingText',
            style: makeTextStyle(16, AppColors.black, 'regular'),
          ),
        ],
      ),
    );
  }
}
