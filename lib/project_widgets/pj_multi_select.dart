import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/models/values_model.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';
import 'package:imigrata_web/screens/survey_screen/controllers/ctrl_survey.dart';

class PjMultiSelect extends StatefulWidget {
  final List<ValuesModel> valueList;
  final int index;

  const PjMultiSelect({Key? key, required this.valueList, required this.index}) : super(key: key);

  @override
  _PjMultiSelectState createState() => _PjMultiSelectState();
}

class _PjMultiSelectState extends State<PjMultiSelect> {
  late List<bool> selected;

  CtrlSurvey ctrlSurvey = Get.find(tag: 'survey');

  @override
  void initState() {
    super.initState();
    selected = List.filled(widget.valueList.length, false);
  }

  @override
  void didUpdateWidget(covariant PjMultiSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    selected = List.filled(widget.valueList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected[widget.index] = !selected[widget.index];
                  });
                  // list.removeLast();
                  if (selected[widget.index] == true) {
                    ctrlSurvey.indexAnswerMultipleSelection.value.add(widget.valueList[widget.index].id!);
                  } else {
                    ctrlSurvey.indexAnswerMultipleSelection.value.remove(widget.valueList[widget.index].id!);
                  }
                },
                child: Container(
                  width: kIsWeb ? 380 : 335.w,
                  // height: kIsWeb ? 40.h : 40.w,
                  padding: EdgeInsets.symmetric(horizontal: kIsWeb ? 10 : 10.w, vertical: kIsWeb ? 20 :  10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kIsWeb ? 8 : 8.w),
                    color: selected[widget.index] == true ? PjColors.blue : PjColors
                        .grey242,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: kIsWeb ? 270 : 290.w,
                        child: PjText(
                          text: widget.valueList[widget.index].name!,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: selected[widget.index] == true
                              ? PjColors.white
                              : PjColors.black,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: kIsWeb ? 16 : 16.w,
                        height: kIsWeb ? 16 : 16.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kIsWeb ? 16 : 16.w),
                          color: selected[widget.index] == true
                              ? PjColors.white
                              : PjColors.grey242,
                          border: selected[widget.index] == false ? Border.all(
                              color: PjColors.grey149, width: 1) : null,
                        ),
                        child: selected[widget.index] == true
                            ? Center(
                          child: SvgPicture.asset(
                              'assets/icons/checkmark.svg'),
                        )
                            : Container(),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: kIsWeb ? 13 : 10.w,),
            ],
          );
  }
}

//ListView.builder(
//           padding: EdgeInsets.zero,
//           itemCount: widget.valueList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selected[index] = !selected[index];
//                     });
//                     // list.removeLast();
//                     if (selected[index] == true) {
//                       ctrlSurvey.indexAnswerMultipleSelection.value.add(widget.valueList[index].id!);
//                     } else {
//                       ctrlSurvey.indexAnswerMultipleSelection.value.remove(widget.valueList[index].id!);
//                     }
//                   },
//                   child: Container(
//                     width: 335.w,
//                     height: 40.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: selected[index] == true ? PjColors.blue : PjColors
//                           .grey242,
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 10.w),
//                           child: PjText(
//                             text: widget.valueList[index].name!,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: selected[index] == true
//                                 ? PjColors.white
//                                 : PjColors.black,
//                           ),
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: EdgeInsets.only(right: 10.w),
//                           child: Container(
//                             width: 16.w,
//                             height: 16.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: selected[index] == true
//                                   ? PjColors.white
//                                   : PjColors.grey242,
//                               border: selected[index] == false ? Border.all(
//                                   color: PjColors.grey149, width: 1) : null,
//                             ),
//                             child: selected[index] == true
//                                 ? Center(
//                               child: SvgPicture.asset(
//                                   'assets/icons/checkmark.svg'),
//                             )
//                                 : Container(),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10.w,),
//               ],
//             );
//           }),