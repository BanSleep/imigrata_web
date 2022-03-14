import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'survey_screen.dart';
import 'cubit/cb_survey_screen.dart';

class SurveyScreenProvider extends StatelessWidget {
  const SurveyScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbSurveyScreen>(
      create: (context) => CbSurveyScreen(),
      child: SurveyScreen(),
    );
  }
}    
    