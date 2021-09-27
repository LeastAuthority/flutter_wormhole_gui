import 'package:flutter/material.dart';
import 'config/routes/routes.dart';
import 'views/introduction-slider.dart';
import 'views/settings.dart';
import 'views/splash.dart';
import 'views/send/send.dart';
import 'package:flutter/widgets.dart';
import 'views/receive/receive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
            return ScreenUtilInit(
                designSize: Size(375,590),
                builder:()=> MaterialApp(
                      // theme: new ThemeData(scaffoldBackgroundColor: Colors.black12),
                      routes: {
                            SPLASH_ROUTE: (context) => Splash(),
                            INTRO_ROUTE: (context) => IntroScreen(),
                            // HOME_ROUTE: (context) => Home(),
                            SEND_ROUTE: (context) => SendDefault(),
                            RECEIVE_ROUTE: (context) => Receive(),
                            SETTINGS_ROUTE: (context) => Settings(),
                      },
                ));
      }
}