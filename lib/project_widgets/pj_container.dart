import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class PjContainer extends StatelessWidget {
  final String text;
  const PjContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kIsWeb ? 10.h : 10.w),
      width: kIsWeb ? 400.h : 335.w,
      decoration: BoxDecoration(
        color: PjColors.grey242,
        borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 8.h : 8.w)),
      ),
      child: PjText(
        text: text,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: PjColors.black,
      ),
    );
  }
}
