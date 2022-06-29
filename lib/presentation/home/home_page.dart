import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.whiteFD,
        title: Row(
          children: [
            Text(
              'Taskker',
              style: AppTextStyle.black(20, weight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Column(),
    );
  }
}
