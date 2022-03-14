import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class SuccessfulPaymentScreen extends StatelessWidget {
  const SuccessfulPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar:  kIsWeb
            ? AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width < 900
                      ? 0
                      : 100,
                ),
                SizedBox(
                    width: 72,
                    height: 66,
                    child: Image.asset('assets/images/icon.png')),
              ],
            )
        ) : null,
        backgroundColor: PjColors.white,
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: kIsWeb ? 380 : null,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!kIsWeb) ... [
                      SizedBox(
                          width: 62.w,
                          height: 56.w,
                          child: Image.asset('assets/images/icon.png')),
                    ],

                    SizedBox(height: kIsWeb ? 200 :  220.w,),
                    Center(child: PjText(text: 'Спасибо за покупку!', fontSize: 24, fontWeight: FontWeight.w400,)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
    