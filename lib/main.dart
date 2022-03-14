import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/screens/analysis_screen/analysis_screen_provider.dart';
import 'package:imigrata_web/screens/payment_screen/payment_screen_provider.dart';
import 'package:imigrata_web/screens/registration_screen/registration_screen_provider.dart';
import 'package:imigrata_web/screens/successful_payment_screen/successful_payment_screen.dart';
import 'package:imigrata_web/screens/survey_screen/survey_screen_provider.dart';
import 'screens/main_screen/main_screen_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  Api.init(
      baseUrl:
          'https://test.imigrata.com:3000/'); //Input your URL. Learn more eticon_api on pub.dev
  // Api.setToken('');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812), //Default size of Iphone XR and 11
      builder: () {
        return  GetCupertinoApp(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          localizationsDelegates: [
            AppLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
        ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ru', ''),
          ],
        debugShowCheckedModeBanner: false,
        home: Api.tokenIsNotEmpty() ? GetStorage().read('isPay') == null ? PaymentScreenProvider() : SuccessfulPaymentScreen() : SurveyScreenProvider(),
      );} ,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
  