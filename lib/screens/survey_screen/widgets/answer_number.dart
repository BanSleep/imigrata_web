import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_forms.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/validate_error.dart';

class AnswerNumber extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  Function() onTap;
  final FormModel formModel;

  AnswerNumber(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.onTap,
      required this.formModel})
      : super(key: key);

  @override
  State<AnswerNumber> createState() => _AnswerNumberState();
}

class _AnswerNumberState extends State<AnswerNumber> {
  late bool isVisible;
  late bool isIncorrectNumber;

  final RegExp regExp = RegExp(r'^[0-9]+$');

  String textError = 'Пожалуйста, заполните это поле';

  @override
  void initState() {
    isVisible = false;
    isIncorrectNumber = false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnswerNumber oldWidget) {

    super.didUpdateWidget(oldWidget);
    isVisible = false;
    isIncorrectNumber = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 120.w
        ),
        child: Padding(
          padding: kIsWeb ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: kIsWeb ? 36 : 36.w,
                  ),
                  SizedBox(
                    width: kIsWeb ? 380 : null,
                    child: PjText(
                      text: widget.formModel.title ?? '',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb ? 20 : 20.w,
                  ),
                  SizedBox(
                    width: kIsWeb ? 380 : null,
                    child: PjText(
                      text: widget.formModel.description!,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb ? 40 : 40.w,
                  ),
                  PjForms(
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      tagTextType: 2,
                      placeHolder: 'Напишите ответ здесь...',
                      onChange: (str) {
                        setState(() {
                          isVisible = false;
                        });
                      }),
                  Visibility(
                      visible: isVisible,
                      child: ValidateError(
                        text: textError,
                        // isIncorrectNumber
                        //     ? 'Пожалуйста, введите число от ${widget.formModel.settings?.number?.min ?? 0} до ${widget.formModel.settings?.number?.max ?? 0}'
                        //     : 'Пожалуйста, заполните это поле',
                      )),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: kIsWeb ? 40 : 40.w,
                  ),
                  PjButton(
                    text: 'Далее',
                    onTap: () {
                      if (widget.controller.text.isNotEmpty) {
                        if (regExp.hasMatch(widget.controller.text)) {
                          if (int.parse(widget.controller.text) >= (widget.formModel.settings?.number?.min ?? 0) &&
                              int.parse(widget.controller.text) <= (widget.formModel.settings?.number?.max ?? 0)) {
                            widget.onTap();
                          } else {
                            setState(() {
                              isVisible = true;
                              textError = 'Пожалуйста, введите число от ${widget.formModel.settings?.number?.min ?? 0} до ${widget.formModel.settings?.number?.max ?? 0}';
                            });
                          }
                        } else {
                          setState(() {
                            isVisible = true;
                            textError = 'Неверно введено число';
                          });
                        }
                      } else {
                        setState(() {
                          isVisible = true;
                          textError = 'Пожалуйста, заполните это поле';
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: kIsWeb ? 50 : 50.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
