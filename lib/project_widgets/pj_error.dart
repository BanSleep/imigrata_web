import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class PjError extends StatelessWidget {
  Function() onTap;

  PjError({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: kIsWeb ? 380 : null,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kIsWeb) ... [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
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
                ),
              ] else ... [
                Padding(
                  padding: EdgeInsets.only(top: 20.w, left: 20.w),
                  child: SizedBox(
                      width: 62.w,
                      height: 56.w,
                      child: Image.asset('assets/images/icon.png', )),
                ),
              ],

              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: kIsWeb ? 240 : 240.w,
                    ),
                    const PjText(
                      text: 'Произошла ошибка, попробуйте повторить позже',
                      color: PjColors.black60,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                    SizedBox(height: kIsWeb ? 30 : 30.w,),
                    PjButton(text: 'Повторить', onTap: onTap,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
