import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_widgets/pj_single_choice.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/survey_screen/controllers/ctrl_survey.dart';
import 'package:imigrata_web/screens/survey_screen/cubit/cb_survey_screen.dart';

class AnswerChoice extends StatefulWidget {
  Function() onTap;
  final FormModel formModel;
  final bool? isNew;

  AnswerChoice(
      {Key? key, required this.onTap, required this.formModel, this.isNew})
      : super(key: key);

  @override
  State<AnswerChoice> createState() => _AnswerChoiceState();
}

class _AnswerChoiceState extends State<AnswerChoice> {
  CtrlSurvey ctrlSurvey = Get.find(tag: 'survey');
  late bool isFirst;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    isFirst = true;
  }

  @override
  void didUpdateWidget(covariant AnswerChoice oldWidget) {
    super.didUpdateWidget(oldWidget);
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ctrlSurvey.indexAnswerChoice.value = -1;
    return SingleChildScrollView(
      child: Padding(
        padding: kIsWeb ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
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
              ],
            ],

            SizedBox(
              height: kIsWeb ? 40 : 40.w,
            ),
            for (int index = 0;
                index <
                    (widget.formModel.settings?.choice?.values?.length ?? 0);
                index++) ...[
              PjSingleChoice(
                textAnswer:
                    widget.formModel.settings?.choice?.values?[index].name ??
                        '',
                isNew: widget.isNew,
                onTap: () {
                  if (isFirst) {
                    // print(isFirst);
                    // ctrlSurvey.indexAnswerChoice.value = index;
                    setState(() {
                      isFirst = false;
                    });
                    BlocProvider.of<CbSurveyScreen>(context).postData(
                        formId: widget.formModel.formId,
                        sessionId: widget.formModel.sessionId,
                        choice: widget
                            .formModel.settings?.choice?.values?[index].id);
                    // print('${isFirst}+++');
                  }
                },
                isPaintButton: isFirst,
              ),
              SizedBox(
                height: widget.formModel.settings!.choice!.values!.length - 1 == index ? kIsWeb ? 40 : 40.w : kIsWeb ? 15 : 10.w,
              ),
            ],
            // ListView.builder(
            //   padding: EdgeInsets.zero,
            //   itemCount: widget.formModel.settings?.choice?.values?.length ?? 0,
            //   itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //         PjSingleChoice(
            //           textAnswer:
            //               widget.formModel.settings?.choice?.values?[index].name ?? '',
            //           isNew: widget.isNew,
            //           onTap: () {
            //             if (isFirst) {
            //               // print(isFirst);
            //               // ctrlSurvey.indexAnswerChoice.value = index;
            //               setState(() {
            //                 isFirst = false;
            //               });
            //               BlocProvider.of<CbSurveyScreen>(context).postData(
            //                   formId: widget.formModel.formId, sessionId: widget.formModel.sessionId, choice: widget.formModel.settings?.choice?.values?[index].id);
            //               // print('${isFirst}+++');
            //             }
            //           },
            //           isPaintButton: isFirst,
            //         ),
            //         SizedBox(
            //           height: 10.w,
            //         ),
            //       ],
            //     );
            //   },
            // ),

            // ],
          ],
        ),
      ),
    );
  }
}
