import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  final String title;
  Function handleSelectFile;
  Button(this.title, this.handleSelectFile);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, handleSelectFile);
}

class _CustomAppBarState extends State<Button> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  _CustomAppBarState(this.title, this.handleSelectFile);

  @override
  Widget build(BuildContext context) {
    //0xff808080
    return Container(
      margin: EdgeInsets.only(top:22.0.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white),
          left: BorderSide(width: 1.0, color:  Colors.white),
          right: BorderSide(width: 1.0, color:  Colors.white),
          bottom: BorderSide(width: 1.0, color:  Colors.white),
        ),
      ),
      width: 120.0.w,
      height: 50.0.w,
      // margin: const EdgeInsets.all(8.0),
      child:  FlatButton(
        onPressed: () => handleSelectFile(),
        color: Color(0x00353846),
        child:Text('${title}', style:TextStyle(color: Colors.white, fontSize: 12.sp, fontFamily: MONTSERRAT)),
      ),
    );
  }
}

