
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("红包领取结果"),
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Text("恭喜您获得88888888元红包", style: TextStyle(color: Colors.redAccent, fontSize: 20.sp),),
        ),
      ),
    );
  }
}
