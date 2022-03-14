import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/screens/analysis_screen/controllers/ctrl_analysis.dart';
import 'package:imigrata_web/screens/analysis_screen/widgets/custom_stepper.dart';
import 'cubit/cb_analysis_screen.dart';
import 'cubit/st_analysis_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  CtrlAnalysis ctrlAnalysis = Get.put(CtrlAnalysis(), tag: 'analysis');

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 7), () {
    //   // GetStorage().read('allComplete') == false
    //   //     ?
    //
    //       // : Get.bottomSheet(
    //       //     Column(
    //       //       crossAxisAlignment: CrossAxisAlignment.end,
    //       //       mainAxisAlignment: MainAxisAlignment.end,
    //       //       mainAxisSize: MainAxisSize.min,
    //       //       children: [
    //       //         Container(
    //       //           width: 375.w,
    //       //           height: 456.w,
    //       //           decoration: BoxDecoration(
    //       //             color: PjColors.white,
    //       //             borderRadius: BorderRadius.only(
    //       //                 topLeft: Radius.circular(40.w),
    //       //                 topRight: Radius.circular(40.w)),
    //       //           ),
    //       //           child: Padding(
    //       //             padding:
    //       //                 EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
    //       //             child: Column(
    //       //               crossAxisAlignment: CrossAxisAlignment.start,
    //       //               mainAxisSize: MainAxisSize.min,
    //       //               children: [
    //       //                 Container(
    //       //                     width: 335.w,
    //       //                     child: PjText(
    //       //                       text:
    //       //                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
    //       //                       fontSize: 16,
    //       //                       fontWeight: FontWeight.w500,
    //       //                     )),
    //       //                 SizedBox(
    //       //                   height: 15.w,
    //       //                 ),
    //       //                 Container(
    //       //                     width: 335.w,
    //       //                     child: PjText(
    //       //                       text:
    //       //                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
    //       //                       fontSize: 16,
    //       //                       fontWeight: FontWeight.w600,
    //       //                     )),
    //       //                 SizedBox(
    //       //                   height: 18.w,
    //       //                 ),
    //       //                 Flexible(
    //       //                     child: PjText(
    //       //                   text:
    //       //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    //       //                   fontSize: 16,
    //       //                   color: PjColors.blue,
    //       //                 )),
    //       //                 SizedBox(
    //       //                   height: 10.w,
    //       //                 ),
    //       //                 Flexible(
    //       //                     child: PjText(
    //       //                   text:
    //       //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    //       //                   fontSize: 16,
    //       //                 )),
    //       //                 SizedBox(
    //       //                   height: 20.w,
    //       //                 ),
    //       //                 Row(
    //       //                   children: [
    //       //                     PjButton(
    //       //                       text: r'1$',
    //       //                       onTap: () {},
    //       //                       isBuyButton: true,
    //       //                       isSmall: true,
    //       //                     ),
    //       //                     SizedBox(
    //       //                       width: 13.w,
    //       //                     ),
    //       //                     PjForms(
    //       //                       placeHolder: AppLocalizations.of(context)!.yourPrice,
    //       //                       width: 161.w,
    //       //                       height: 54.w,
    //       //                       centerText: true,
    //       //                       tagTextType: 2,
    //       //                     ),
    //       //                   ],
    //       //                 ),
    //       //                 SizedBox(
    //       //                   height: 15.w,
    //       //                 ),
    //       //                 PjButton(text: AppLocalizations.of(context)!.ok, onTap: () {}),
    //       //               ],
    //       //             ),
    //       //           ),
    //       //         ),
    //       //       ],
    //       //     ),
    //       //     isScrollControlled: true);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
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
            )
        ) : null,
        backgroundColor: PjColors.white,
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: kIsWeb ? 380 : null,
              child: BlocBuilder<CbAnalysisScreen, StAnalysisScreen>(
                builder: (context, state) {
                  if (state is StAnalysisScreenLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (state is StAnalysisScreenLoaded) {
                    return SafeArea(
                        child: Padding(
                      padding: kIsWeb ? EdgeInsets.only(top: 20) : EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!kIsWeb) ... [
                            SizedBox(
                                width: 62.w,
                                height: 56.w,
                                child: Image.asset('assets/images/icon.png')),
                          ],
                          SizedBox(
                            height: kIsWeb ? 140 : 167.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Flexible(
                                  child: Center(
                                child: PjText(
                                  text: 'Тут будет очень интересный текст',
                                  align: TextAlign.center,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              )),
                              SizedBox(
                                height: kIsWeb ? 60 : 60.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: kIsWeb ? 0 : 28.w),
                                child: Row(
                                  mainAxisAlignment: kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
                                  children: [
                                    const CustomStepper(),
                                  ],
                                ),
                              ),
                              if (kIsWeb) ... [
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ],
                          )
                        ],
                      ),
                    ));
                  }
                  if (state is StAnalysisScreenError) {
                    return Container(color: Colors.red);
                  }
                  return Container(color: Colors.grey);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
