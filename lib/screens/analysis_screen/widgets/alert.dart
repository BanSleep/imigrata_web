import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Alert extends StatelessWidget {
  Function() onTapYes;
  Function() onTapNo;

  Alert({Key? key, required this.onTapYes, required this.onTapNo}) : super(key: key);

  // CtrlAnalysis ctrlAnalysis = Get.find(tag: 'analysis');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: kIsWeb ? 325 : 325.w,
        height: kIsWeb ? 182 : 182.w,
        decoration: BoxDecoration(
          color: PjColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: kIsWeb ? 25 : 25.w, top: kIsWeb ? 35.h : 35.w, right: kIsWeb ? 25.h : 25.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: PjText(
                    text: AppLocalizations.of(context)!.oneMoreQuestion,
                    align: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(
                height: kIsWeb ? 40 : 40.w,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PjButton(
                    text: AppLocalizations.of(context)!.yes,
                    onTap: onTapYes,
                    isSmall: true,
                  ),
                  SizedBox(
                    width: kIsWeb ? 25 : 25.w,
                  ),
                  PjButton(
                      text: AppLocalizations.of(context)!.no,
                      onTap: onTapNo,
                      isSmall: true),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
