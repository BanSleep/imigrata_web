import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_choice_option.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/survey_screen/controllers/ctrl_survey.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/validate_error.dart';

class AnswerDropdown extends StatefulWidget {
  Function() onTap;
  FocusNode focusNode;
  final FormModel formModel;
  final TextEditingController controller;

  AnswerDropdown({
    Key? key,
    required this.onTap,
    required this.focusNode,
    required this.formModel,
    required this.controller,
  }) : super(key: key);

  @override
  State<AnswerDropdown> createState() => _AnswerDropdownState();
}

class _AnswerDropdownState extends State<AnswerDropdown> {
  late bool isVisible = false;
  late bool isClose = false;

  CtrlSurvey ctrlSurvey = Get.find(tag: 'survey');

  @override
  void initState() {
    isVisible = false;
    isClose = false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnswerDropdown oldWidget) {
    isVisible = false;
    isClose = false;
    super.didUpdateWidget(oldWidget);
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
                    width: kIsWeb ? 380.h : null,
                    child: PjText(
                      text: widget.formModel.title ?? '',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                  if (widget.formModel.description != null) ...[
                    if (widget.formModel.description!.isNotEmpty) ...[
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
                        height: kIsWeb ? 20 : 20.w,
                      ),
                    ],
                  ],
                  SizedBox(
                    height: kIsWeb ? 20 : 20.w,
                  ),
                  PjChoiceOption(
                    controller: widget.controller,
                    formModel: widget.formModel,
                    focusNode: widget.focusNode,
                    onTap: () {
                      setState(() {
                        isVisible = false;
                      });
                    },
                  ),
                  Visibility(
                      visible: isVisible,
                      child: ValidateError(
                        text: 'Пожалуйста, заполните это поле',
                      )),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: kIsWeb ? 40 : 40.w,
                  ),
                  PjButton(text: 'Далее', onTap: () {
                    if (widget.controller.text.isNotEmpty) {
                        widget.onTap();
                    } else {
                      ctrlSurvey.isValidate.value = true;
                      setState(() {
                        isVisible = true;
                      });
                    }
                  }),
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
