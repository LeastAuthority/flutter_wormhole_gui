import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class CustomBottomBar extends StatelessWidget {
  String? path;
  CustomBottomBar({Key? key, String? path}):super(key:key){
    this.path = path;
  }
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.4);
    Decoration getCurrentPath (String screen) {
      if(path == screen)
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      else if(path == screen){
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      }
      return  BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.0, color: Color(0xff353846)),
        ),
      );
    }
    return Container(
        padding: EdgeInsets.only(bottom: 1.0),
        color: Colors.black,
        child: Container(
        height: 55.0.h,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded (
              flex:1,
              child: Container(
                decoration: getCurrentPath(SEND_ROUTE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SEND_ROUTE);
                          },
                          child:  Column(
                            children: [
                            Image.asset(
                            SEND_ICON,
                            width: 40.0.w,
                            height: 20.0.h,
                          ),
                              Text(
                                SEND,
                                style: TextStyle(color: Colors.white, fontFamily: LATO, fontSize: 12.sp),
                              )
                            ],
                          )
                    ),
                  ],
                ),
              )
            ),
            Expanded (
                flex:1,
                child: Container(
                  decoration: getCurrentPath(RECEIVE_ROUTE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                             TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RECEIVE_ROUTE);
                              },
                              child:  Column(
                                children: [
                                  Image.asset(
                                    RECEIVE_ICON,
                                    width: 40.0.w,
                                    height: 20.0.h,
                                  ),
                                  Text(
                                    RECEIVE,
                                    style: TextStyle(color: Colors.white, fontFamily: LATO, fontSize: 12.sp),
                                  )
                                ],
                              )
                          ),
                    ],
                  ),
                )
            ),
          ],
        ),
    )
    );
  }
}
