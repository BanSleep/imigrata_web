import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_utils/pj_colors.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_multi_select.dart';
import 'package:imigrata_web/project_widgets/pj_text.dart';

class AnswerMultipleSelection extends StatelessWidget {
  Function() onTap;
  final FormModel formModel;

  AnswerMultipleSelection(
      {Key? key, required this.onTap, required this.formModel})
      : super(key: key);



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
                      text: formModel.title!,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb ? 20 : 20.w,
                  ),
                  if (formModel.description != null) ... [
                    if (formModel.description!.isNotEmpty) ... [
                      SizedBox(
                        width: kIsWeb ? 380 : null,
                        child: PjText(
                          text: formModel.description!,
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

                  const PjText(
                    text: 'Вы можете выбрать несколько вариантов',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    align: TextAlign.center,
                    color: PjColors.blue,
                  ),
                  SizedBox(
                    height: kIsWeb ? 20 : 20.w,
                  ),
                  for (int index = 0; index < (formModel.settings?.multipleSelection?.values?.length ?? 0); index++) ... [
                    PjMultiSelect(valueList: formModel.settings?.multipleSelection?.values ?? [], index: index,),
                  ],
                ],
              ),

              Column(
                children: [
                  SizedBox(
                    height: kIsWeb ? 40 : 40.w,
                  ),
                  PjButton(text: 'Далее', onTap: onTap),
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
