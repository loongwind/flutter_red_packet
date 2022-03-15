

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_red_packet/red_packet_controller.dart';
import 'package:flutter_red_packet/red_packet_painter.dart';
import 'package:flutter_red_packet/result.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


OverlayEntry? entry;
void showRedPacket(BuildContext context, Function? onOpen){
  entry = OverlayEntry(builder: (context) => RedPacket(onFinish: _removeRedPacket, onOpen: onOpen,));
  Overlay.of(context)?.insert(entry!);
}

void _removeRedPacket(){
  entry?.remove();
  entry = null;
}


class RedPacket extends StatefulWidget {

  Function? onFinish;
  Function? onOpen;
  RedPacket({Key? key,this.onFinish, this.onOpen}) : super(key: key);



  @override
  _RedPacketState createState() => _RedPacketState();
}

class _RedPacketState extends State<RedPacket> with TickerProviderStateMixin{

  late RedPacketController controller = RedPacketController(tickerProvider: this);

  @override
  void initState() {
    super.initState();
    controller.onOpen = widget.onOpen;
    controller.onFinish = widget.onFinish;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0x88000000),
      child: GestureDetector(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(parent: controller.scaleController, curve: Curves.fastOutSlowIn)),
          child: buildRedPacket(),
        ),
        onPanDown: (d) => controller.handleClick(d.globalPosition),
      ),
    );
  }

  Widget buildRedPacket() {
    return GestureDetector(
      onTapUp: controller.clickGold,
      child: CustomPaint(
        size: Size(1.sw, 1.sh),
        painter: RedPacketPainter(controller: controller),
        child: buildChild(),
      ),
    );
  }


  Widget buildChild() {
    return AnimatedBuilder(
      animation: controller.translateController,
      builder: (context, child) => Container(
        padding: EdgeInsets.only(top: 0.3.sh * (1 - controller.translateCtrl.value)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(3.w),
                    child: Image.network("https://p26-passport.byteacctimg.com/img/user-avatar/32f1f514b874554f69fe265644ca84e4~300x300.image", width: 24.w,)),
                SizedBox(width: 5.w,),
                Text("loongwind发出的红包", style: TextStyle(fontSize: 16.sp, color: Color(
                    0xFFF8E7CB), fontWeight: FontWeight.w500),)
              ],
            ),
            SizedBox(height: 15.w,),
            Text("恭喜发财", style: TextStyle(fontSize: 18.sp, color: Color(
                0xFFF8E7CB)),)
          ],
        ),
      ),
    );
  }


}


