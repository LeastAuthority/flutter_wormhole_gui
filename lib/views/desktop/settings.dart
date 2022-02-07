import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/views/shared/settings.dart';

class Settings extends SettingsState {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends SettingsShared<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          path: SETTINGS_ROUTE,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border(
                    top: BorderSide(width: 2.0, color: CustomColors.purple),
                    left: BorderSide(width: 2.0, color: CustomColors.purple),
                    right: BorderSide(width: 2.0, color: CustomColors.purple),
                    bottom: BorderSide(width: 2.0, color: CustomColors.purple),
                  ),
                ),
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                child: Container(
                    height: double.infinity,
                    margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
                    padding: EdgeInsets.only(top: 80.0.h),
                    child: Column(
                      children: [
                        Heading(
                          title: SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE,
                          textAlign: TextAlign.center,
                          marginTop: 16.0.h,
                          textStyle: Theme.of(context).textTheme.headline1,
                          // key: Key('Timing_Progress'),
                        ),
                       Column(
                         children: [
                           Heading(
                             title: '$CURRENT_SAVE_DESTINATION',
                             textAlign: TextAlign.center,
                             marginTop: 110.0.h,
                             path: path,
                             textStyle: Theme.of(context).textTheme.headline1,
                             key: Key(SETTINGS_SCREEN_HEADING),
                           ),
                           SizedBox(
                             height: 45.0.h,
                           ),
                           DTButtonWithBackground(
                             handleSelectFile: handleSelectFile,
                             title: SELECT_A_FOLDER,
                             width: 150.0.w,
                           )
                         ],
                       )
                      ],
                    )),
              ),
            )));
  }
}
