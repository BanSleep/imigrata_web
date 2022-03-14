import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_utils/pj_const.dart';
import 'package:imigrata_web/project_utils/pj_icons.dart';
import 'package:imigrata_web/project_widgets/pj_error.dart';
import 'package:imigrata_web/screens/analysis_screen/analysis_screen_provider.dart';
import 'package:imigrata_web/screens/survey_screen/controllers/ctrl_survey.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_button.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_dropdown.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_choice.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_multiple_selection.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_text.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/answer_number.dart';
import 'cubit/cb_survey_screen.dart';
import 'cubit/st_survey_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class SurveyScreen extends StatefulWidget {
  SurveyScreen({Key? key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  CtrlSurvey ctrlSurvey = Get.put(CtrlSurvey(), tag: 'survey');

  bool isFirst = true;
  bool isMove = false;
  bool isAppBar = true;

  bool isFirstQuestion = true;

  @override
  initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // FlutterStatusbarcolor.setStatusBarColor(PjColors.black);
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (GetStorage().read(PjConst.SESSION_ID) != null &&
              GetStorage().read(PjConst.FORM_ID) != null &&
              !isFirstQuestion) {
            BlocProvider.of<CbSurveyScreen>(context).getData();
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: PjColors.white,
          appBar: kIsWeb
                  ? AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      title: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width < 900
                                ? 0
                                : 100,
                          ),
                          SizedBox(
                              width: 72,
                              height: 66,
                              child: Image.asset('assets/images/icon.png')),
                        ],
                      ))
                  : null,
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    width: kIsWeb ? 380 : null,
                    child: BlocConsumer<CbSurveyScreen, StSurveyScreen>(
                      listener: (context, state) {
                        if (state is StSurveyScreenEnd) {
                          Get.offAll(const AnalysisScreenProvider());
                        }
                        if (state is StSurveyScreenLoaded) {
                          setState(() {
                            if (state.formModel.formIndex != 0) {
                              isFirstQuestion = false;
                            } else {
                              isFirstQuestion = true;
                            }
                            isAppBar = true;
                          });
                        }
                        if (state is StSurveyScreenError) {
                          setState(() {
                            isAppBar = false;
                          });
                        }
                        if (state is StSurveyScreenNoInternetError) {
                          setState(() {
                            isAppBar = false;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is StSurveyScreenInit) {
                          if (isFirst) {
                            BlocProvider.of<CbSurveyScreen>(context).postData();
                            isFirst = false;
                          }
                          return Container(
                            color: Colors.white,
                          );
                        }
                        if (state is StSurveyScreenLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        if (state is StSurveyScreenLoaded) {
                          return kIsWeb
                              ? Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      children: [
                                        if (!isFirstQuestion) ...[
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              if (GetStorage().read(
                                                          PjConst.SESSION_ID) !=
                                                      null &&
                                                  GetStorage().read(
                                                          PjConst.FORM_ID) !=
                                                      null) {
                                                BlocProvider.of<CbSurveyScreen>(
                                                        context)
                                                    .getData();
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2, right: 28),
                                              child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: SvgPicture.asset(
                                                    PjIcons.back),
                                              ),
                                            ),
                                          )
                                        ] else ...[
                                          SizedBox(
                                            height: 33,
                                          ),
                                        ]
                                      ],
                                    ),
                                    widgetView(textController, focusNode,
                                        state.formModel),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 20.w, left: 20.w),
                                      child: SizedBox(
                                          width: 62.w,
                                          height: 56.w,
                                          child: Image.asset(
                                              'assets/images/icon.png')),
                                    ),
                                    if (!isFirstQuestion) ...[
                                      SizedBox(
                                        height: 20.w,
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          if (GetStorage().read(
                                                      PjConst.SESSION_ID) !=
                                                  null &&
                                              GetStorage()
                                                      .read(PjConst.FORM_ID) !=
                                                  null) {
                                            BlocProvider.of<CbSurveyScreen>(
                                                    context)
                                                .getData();
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.w,
                                              top: 4.w,
                                              bottom: 4.w,
                                            right: 20.w
                                          ),
                                          child: SizedBox(
                                            width: 25.w,
                                            height: 25.w,
                                            child:
                                                SvgPicture.asset(PjIcons.back),
                                          ),
                                        ),
                                      ),
                                    ] else ... [
                                      SizedBox(
                                        height: 53.w,
                                      )
                                    ],
                                    widgetView(textController, focusNode,
                                        state.formModel),
                                  ],
                                );
                        }
                        if (state is StSurveyScreenError) {
                          return PjError(
                            onTap: () {
                              BlocProvider.of<CbSurveyScreen>(context)
                                  .postData();
                              // setState(() {
                              //   isAppBar = true;
                              // });
                            },
                          );
                        }
                        if (state is StSurveyScreenNoInternetError) {
                          return PjError(
                            onTap: () {
                              BlocProvider.of<CbSurveyScreen>(context)
                                  .postData();
                              // setState(() {
                              //   isAppBar = true;
                              // });
                            },
                          );
                        }
                        return Container(color: PjColors.white);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetView(TextEditingController controller, FocusNode focusNode,
      FormModel formModel) {
    Widget needToSend = Container(color: PjColors.white);

    controller.clear();
    focusNode.unfocus();
    bool isNew = false;
    if (formModel.formType == 'text') {
      needToSend = AnswerText(
        controller: controller,
        focusNode: focusNode,
        formModel: formModel,
        onTap: () {
          if (controller.text.isNotEmpty) {
            BlocProvider.of<CbSurveyScreen>(context).postData(
                formId: formModel.formId,
                sessionId: formModel.sessionId,
                text: controller.text);
          }
        },
      );
    }
    if (formModel.formType == 'button') {
      needToSend = AnswerButton(
        formModel: formModel,
        onTap: () {
          BlocProvider.of<CbSurveyScreen>(context).postData(
              formId: formModel.formId, sessionId: formModel.sessionId);
        },
      );
    }
    if (formModel.formType == 'number') {
      needToSend = AnswerNumber(
          controller: controller,
          focusNode: focusNode,
          formModel: formModel,
          onTap: () {
            if (controller.text.isNotEmpty) {
              BlocProvider.of<CbSurveyScreen>(context).postData(
                  formId: formModel.formId,
                  sessionId: formModel.sessionId,
                  number: int.parse(controller.text));
            }
          });
    }
    if (formModel.formType == 'dropdown') {
      needToSend = AnswerDropdown(
          controller: controller,
          focusNode: focusNode,
          formModel: formModel,
          onTap: () {
            BlocProvider.of<CbSurveyScreen>(context).postData(
                formId: formModel.formId,
                sessionId: formModel.sessionId,
                dropdown: ctrlSurvey.indexAnswerDropdown.value);
          });
    }
    if (formModel.formType == 'choice') {
      needToSend =
          AnswerChoice(formModel: formModel, onTap: () {}, isNew: isNew);
      isNew = true;
    }
    if (formModel.formType == 'multipleSelection') {
      needToSend = AnswerMultipleSelection(
          formModel: formModel,
          onTap: () {
            BlocProvider.of<CbSurveyScreen>(context).postData(
                formId: formModel.formId,
                sessionId: formModel.sessionId,
                multipleSelection:
                    ctrlSurvey.indexAnswerMultipleSelection.value);
          });
    }
    //needToSend =Container();

    return needToSend;
  }
}
