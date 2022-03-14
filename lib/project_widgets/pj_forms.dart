import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';

class PjForms extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int tagTextType;
  final String? placeHolder;
  final double width;
  final double height;
  final bool centerText;
  final Function(String)? onChange;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final bool isCardNumber;
  final bool isDate;


  const PjForms({Key? key,
    this.isCardNumber = false,
    this.isDate = false,
    this.maxLength,
    this.onEditingComplete,
    this.textInputAction,
    this.controller,
    this.focusNode,
    required this.tagTextType,
    required this.placeHolder,
    this.width = kIsWeb ? 380 : 335,
    this.height = 54,
    this.centerText = false,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _PjFormsState createState() => _PjFormsState();
}

class _PjFormsState extends State<PjForms> {
  @override
  Widget build(BuildContext context) {
    TextInputType typeKey;
    switch (widget.tagTextType) {
      case 1:
        typeKey = TextInputType.text;
        break;
      case 2:
        typeKey = TextInputType.number;
        break;
      case 3:
        typeKey = TextInputType.emailAddress;
        break;
      case 4:
        typeKey = TextInputType.phone;
        break;
      default:
        typeKey = TextInputType.text;
        break;
    }
    return SizedBox(
      width: kIsWeb ? widget.width : widget.width.w,
      height: kIsWeb ? widget.height : widget.height.w,
      child: CupertinoTextField(
        inputFormatters: widget.isCardNumber ? !widget.isDate ? [
          FilteringTextInputFormatter.digitsOnly,
          CustomInputFormatter()
        ] : [CustomInputFormatterDate()] : null,
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText,
        onEditingComplete: widget.onEditingComplete,
        textCapitalization: widget.textCapitalization,
        onChanged: widget.onChange,
        textAlign: widget.centerText == true ? TextAlign.center : TextAlign.left,
        padding: widget.centerText == true ? const EdgeInsets.all(0) : EdgeInsets.only(left: kIsWeb ? 16 : 16.w, top: kIsWeb ? 16 : 16.w, bottom: kIsWeb ? 16 : 16.w ),
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: typeKey,
        style: TextStyle(
          fontFamily: 'SanFrancisco',
          color: PjColors.black,
          fontWeight: FontWeight.w500,
          fontSize: kIsWeb ? 18 : 18.w,

        ),
        placeholder: widget.placeHolder,
        placeholderStyle: TextStyle(
          fontFamily: 'SanFrancisco',
          fontWeight: FontWeight.w500,
          fontSize: kIsWeb ? 18 : 18.w,
          color: PjColors.grey149,

        ),
        decoration: BoxDecoration(
          color: PjColors.grey242,
          borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 8.h : 8.w)),
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      log (text.length.toString());

      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}
class CustomInputFormatterDate extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }


    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      log(text.length.toString(), name: "textLength");
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      log(nonZeroIndex.toString(), name: 'nonZeroIndex');
      if (text.length == 2 && i == 1  && !GetStorage().read('isDelete')) {
        GetStorage().write('isDelete', true);
        buffer.write('/'); // Replace this with anything you want to put after each 4 numbers
      }
      if (text.length == 1) {
        GetStorage().write('isDelete', false);
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}
