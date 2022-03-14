import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_container.dart';
import 'package:imigrata_web/screens/survey_screen/controllers/ctrl_survey.dart';

class PjChoiceOption extends StatefulWidget {
  FormModel formModel;
  // final int countChoice;
  final FocusNode focusNode;
  final TextEditingController controller;
  Function()? onTap;

  PjChoiceOption(
      {Key? key,
      required this.formModel,
      // required this.countChoice,
      required this.focusNode,
      required this.controller,
      this.onTap,
      })
      : super(key: key);

  @override
  _PjChoiceOptionState createState() => _PjChoiceOptionState();
}

class _PjChoiceOptionState extends State<PjChoiceOption> {
  bool isTap = false;
  late String textAnswer;
  late Color colorTextAnswer;

  CtrlSurvey ctrlSurvey = Get.find(tag: 'survey');

  @override
  void initState() {
    textAnswer = 'Выберите вариант';
    colorTextAnswer = PjColors.grey149;
    ctrlSurvey.isValidate.listen((p0) {
      if (widget.controller.text.isEmpty && ctrlSurvey.isValidate.value) {
        setState(() {
          isTap = false;
        });
        ctrlSurvey.isValidate.value = false;
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PjChoiceOption oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    textAnswer = 'Выберите вариант';
    colorTextAnswer = PjColors.grey149;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          setState(() {
            isTap = !isTap;
          });
          ctrlSurvey.isValidate.value = false;
          widget.onTap!();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(kIsWeb ? 16 : 16.w),
            decoration: BoxDecoration(
              color: PjColors.grey242,
              borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 8.h : 8.w)),
            ),
            height: kIsWeb ? 54 : 54.w,
            width: kIsWeb ? 380 : 335.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: kIsWeb ? 279 : 279.w,
                  child: Text(
                    textAnswer,
                    // softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'SanFrancisco',
                      fontSize: kIsWeb ? 16 : 16.w,
                      fontWeight: FontWeight.w500,
                      color: colorTextAnswer,
                    ),
                  ),
                ),
                SizedBox(
                  height: kIsWeb ? 24 :24.w,
                  width: kIsWeb ? 24 : 24.w,
                  child: SvgPicture.asset(
                    isTap ? PjIcons.arrowForward : PjIcons.arrowForwardDown,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kIsWeb ? 8 : 8.w,
          ),
          Visibility(
            visible: isTap,
            child: SizedBox(
              height: kIsWeb ? 316 : 316.w,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.formModel.settings!.dropdown!.values?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.formModel.settings?.dropdown?.values?[index].name == null ? '' : textAnswer = widget.formModel.settings!.dropdown!.values![index].name!;
                              widget.controller.text = textAnswer;
                              colorTextAnswer = PjColors.black;
                              isTap = !isTap;
                            });
                            ctrlSurvey.indexAnswerDropdown.value = widget.formModel.settings?.dropdown?.values?[index].id! ?? '0';
                          },
                          child: PjContainer(text: widget.formModel.settings?.dropdown?.values?[index].name! ?? '')),
                      SizedBox(
                        height: kIsWeb ? 6 : 6.w,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
