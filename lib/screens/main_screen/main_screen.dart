import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imigrata_web/project_widgets/pj_forms.dart';
import 'package:imigrata_web/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/cb_main_screen.dart';
import 'cubit/st_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(),
      body: BlocBuilder<CbMainScreen, StMainScreen>(
        builder: (context, state) {
          if (state is StMainScreenLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is StMainScreenLoaded) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 50.w, horizontal: 20.w),
              child: Column(
                children: [
                  PjForms(
                    tagTextType: 1,
                    placeHolder: 'Напишите ответ здесь...',
                  ),
                  SizedBox(height: 20.w,),
                  // PjSingleChoice(textAnswer: 'Основное общее образование (9 классов)',
                  // ),
                  SizedBox(height: 20.w,),
                  // PjChoiceOption(listChoice: ['Азербайджанская Республика'], countChoice: 1,),
                ],
              ),
            );
          }

          if (state is StMainScreenError) {
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
  }
}
