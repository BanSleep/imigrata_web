import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_forms.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/validate_error.dart';

class AnswerText extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  FormModel formModel;
  Function() onTap;

  AnswerText(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.onTap,
      required this.formModel})
      : super(key: key);

  @override
  State<AnswerText> createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {
  late bool isVisible;
  GlobalKey gKey = GlobalKey();

  ScrollController controller = ScrollController();

  @override
  void initState() {
    isVisible = false;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnswerText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    isVisible = false;
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
                  if (widget.formModel.description != null) ...[
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
                  ],
                  SizedBox(
                    height: kIsWeb ? 40 : 40.w,
                  ),
                  PjForms(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    tagTextType: 1,
                    placeHolder: 'Напишите ответ здесь...',
                    onChange: (str) {
                      setState(() {
                        isVisible = false;
                      });
                    },
                  ),
                  Visibility(
                      visible: isVisible,
                      child: const ValidateError(
                        text: 'Пожалуйста, заполните это поле',
                      )),

                ],
              ),
              // SizedBox(
              //     height: 300.w,
              //     width: 300.w,
              //     child: Image.asset(
              //       'assets/images/goma.gif',
              //     )),

              Column(
                children: [
                  SizedBox(
                    height:
                    kIsWeb ? 40 : 40.w,
                    // controller.hasClients ? controller.position.maxScrollExtent > 0 ? 40.w : MediaQuery.of(context).size.height - 157.w - 154.w : MediaQuery.of(context).size.height - 157.w - 154.w
                  ),
                  PjButton(
                    text: 'Далее',
                    // onTap: onTap,
                    onTap: () {
                      if (widget.controller.text.isNotEmpty) {
                        widget.onTap();
                      } else {
                        setState(() {
                          isVisible = true;
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
