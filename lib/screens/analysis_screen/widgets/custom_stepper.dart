import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/analysis_screen/controllers/ctrl_analysis.dart';
import 'package:imigrata_web/screens/registration_screen/registration_screen_provider.dart';
import 'alert.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({Key? key}) : super(key: key);

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  CtrlAnalysis ctrlAnalysis = Get.find(tag: 'analysis');

  List<bool> completed = [false, false, false, false];

  void last () {
    Future.delayed(Duration(seconds: 2), () {
      Get.dialog(
        Alert(
          onTapYes: () {
            setState(() {
              completed[3] = true;
            });
            // ctrlAnalysis.isNextStep.value = true;
            Get.back();
            Future.delayed(Duration(seconds: 4), () {
              Get.offAll(const RegistrationScreenProvider());
            });
          },
          onTapNo: () {
            setState(() {
              completed[3] = true;
            });
            // ctrlAnalysis.isNextStep.value = true;
            Get.back();
            Future.delayed(Duration(seconds: 4), () {
              Get.offAll(const RegistrationScreenProvider());
            });
          },
        ),
        barrierDismissible: false,
      );

    });


  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        completed[0] = true;
      });
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        completed[1] = true;
      });
      Timer(Duration(seconds: 2), () {
        Get.dialog(
          Alert(
            onTapYes: () {
              setState(() {
                completed[2] = true;
              });
              // ctrlAnalysis.isNextStep.value = true;
              Get.back();
              last();
            },
            onTapNo: () {
              setState(() {
                completed[2] = true;
              });
              // ctrlAnalysis.isNextStep.value = true;
              Get.back();
              last();
            },
          ),
          barrierDismissible: false,
        );
      });
    });
    if (completed.last == true) {
      GetStorage().write('allComplete', true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        for (int i = 0; i < completed.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    width: kIsWeb ? 22 : 22.w,
                    height: kIsWeb ? 22 : 22.w,
                    decoration: BoxDecoration(
                      color: completed[i] == true ? PjColors.green : null,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                          color: completed[i] == true
                              ? PjColors.green
                              : PjColors.grey166),
                    ),
                    duration: Duration(seconds: 2),
                    child: completed[i] == true
                        ? SvgPicture.asset(
                            'assets/icons/checkmark.svg',
                            color: PjColors.white,
                            fit: BoxFit.none,
                          )
                        : null,
                  ),
                  i < completed.length - 1
                      ? AnimatedContainer(
                          duration: Duration(seconds: 2),
                          width: kIsWeb ? 2 : 2.w,
                          height: kIsWeb ? 42 : 42.w,
                          color: completed[i] == true
                              ? PjColors.green
                              : PjColors.grey166,
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                width: kIsWeb ? 28 : 28.w,
              ),
              PjText(
                text: 'Какой-то пункт ${i + 1}',
                fontSize: 14,
              )
            ],
          )
        ],
      ],
    );
  }
}
