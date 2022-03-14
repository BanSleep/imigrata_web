import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PjText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? align;

  const PjText(
      {Key? key, required this.text, this.color, this.fontSize = 14, this.fontWeight, this.align}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'SanFrancisco',
        fontWeight: fontWeight,
        color: color,
        fontSize: kIsWeb ? fontSize! : fontSize!.w,
      ),
    );
  }
}
  