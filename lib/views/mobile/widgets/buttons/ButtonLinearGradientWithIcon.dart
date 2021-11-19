import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLinearGradientWithIcon extends StatelessWidget {
  String label = '';
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool? isVertical;
  bool isCodeGenerating = false;

  ButtonLinearGradientWithIcon({
    String label = '', Function? handleSelectFile,
    Widget? icon, double? height,
    double? width, bool? isVertical,
    bool isCodeGenerating = false,
    Key? key}):super(key:key) {
    this.label = label;
    this.isVertical = isVertical;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.isCodeGenerating = isCodeGenerating;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {

    BoxDecoration getBorder () {
      var BORDER_COLOR = this.isVertical!?
        Theme.of(context).colorScheme.secondary :
         Theme.of(context).primaryColor;
      return  BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(width: 2.0, color: BORDER_COLOR),
          left: BorderSide(width: 2.0, color: BORDER_COLOR),
          right: BorderSide(width: 2.0, color: BORDER_COLOR),
          bottom: BorderSide(width: 2.0, color: BORDER_COLOR),
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
       decoration:  BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         border: Border(
           top: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           left: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           right: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           bottom: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
         ),
         gradient: LinearGradient(
           begin: Alignment.centerLeft,
           colors: <Color>[
             Theme.of(context).primaryColor,
             CustomColors.lightBlue
           ], // red to yellow
           tileMode: TileMode.repeated, // repeats the gradient over the canvas
         ),
       ),
      child: Container(
        decoration: getBorder(),
        width: width,
        height: height,
        child:  FlatButton(
            onPressed: () {
              if(handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              child: Row( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Expanded(
                    flex: 11,
                    child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style:Theme.of(context).textTheme.headline4
                    ),
                  ),
                  isCodeGenerating ? Expanded(
                    flex: 2,
                    child: SizedBox(
                      // width: 25.0.w,
                      height: 25.0.h,
                      child: icon,
                    ),): Container()
                ],
              ),
            )
        ),
      ),
    );
  }
}
