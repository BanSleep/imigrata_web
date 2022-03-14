import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_utils/pj_icons.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class ValidateError extends StatelessWidget {
  final String text;

  const ValidateError({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kIsWeb ? 10 : 10.w,),
        Container(
          decoration: BoxDecoration(
            color: PjColors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 8 : 8.w)),
          ),
          width: kIsWeb ? 380 : 335.w,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: kIsWeb ? 16 : 16.w, top: kIsWeb ? 6 : 6.w, bottom: kIsWeb ? 6 : 6.w, right: kIsWeb ? 10 : 10.w),
                child: SizedBox(
                  height: kIsWeb ? 24 : 24.w,
                  width: kIsWeb ? 24 : 24.w,
                  child: SvgPicture.asset(PjIcons.reportProblem),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kIsWeb ? 11.h : 11.w),
                width: kIsWeb ? 270 : 220.w,
                child: PjText(text: text, fontSize: 12,fontWeight: FontWeight.w400,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
