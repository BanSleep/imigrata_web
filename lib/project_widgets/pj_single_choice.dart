import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class PjSingleChoice extends StatefulWidget {
  final String textAnswer;
  Function()? onTap;
  final bool isPaintButton;
  bool? isNew;

  PjSingleChoice({
    Key? key,
    required this.textAnswer,
    this.onTap,
    required this.isPaintButton,
    this.isNew,
  }) : super(key: key);

  @override
  _PjSingleChoiceState createState() => _PjSingleChoiceState();
}

class _PjSingleChoiceState extends State<PjSingleChoice> {
  late Color colorBoxAnswer;
  late Color colorTextAnswer;

  @override
  void initState() {
    colorBoxAnswer = PjColors.grey242;
    colorTextAnswer = PjColors.black;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PjSingleChoice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isPaintButton) {
      colorBoxAnswer = PjColors.grey242;
      colorTextAnswer = PjColors.black;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
      // if (widget.isPaintButton) {
          setState(() {
            colorBoxAnswer = PjColors.blue;
            colorTextAnswer = PjColors.white;
          });
        // }
        widget.onTap!() ?? () {};
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.all(kIsWeb ? 20 : 10.w),
        decoration: BoxDecoration(
          color: colorBoxAnswer,
          borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 8.h : 8.w)),
        ),
        width: kIsWeb ? 380 : 335.w,
        child: PjText(
          text: widget.textAnswer,
          color: colorTextAnswer,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
