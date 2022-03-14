import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class PjButton extends StatefulWidget {
  final bool isSmall;
  final bool isBuyButton;
  final Function() onTap;
  final String text;
  const PjButton({Key? key, this.isSmall = false, this.isBuyButton = false, required this.text, required this.onTap}) : super(key: key);

  @override
  _PjButtonState createState() => _PjButtonState();
}

class _PjButtonState extends State<PjButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: kIsWeb ? widget.isSmall ? widget.isBuyButton ? 154 : 110 : 335 : widget.isSmall ? widget.isBuyButton ? 154.w : 110.w : 335.w,
        height: kIsWeb ? widget.isSmall ? widget.isBuyButton ? 54 : 40 : 50 : widget.isSmall ? widget.isBuyButton ? 54.w : 40.w : 50.w,
        decoration: BoxDecoration(
          color: widget.isBuyButton ? PjColors.grey242 : PjColors.blue,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Center(
          child: PjText(
            fontSize: widget.isSmall ? 18 : 22,
            fontWeight: FontWeight.w200,
            text: widget.text,
            color: widget.isBuyButton ? PjColors.black : PjColors.white,
          ),
        ),
      ),
    );
  }
}
