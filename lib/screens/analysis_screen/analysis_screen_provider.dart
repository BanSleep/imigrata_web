import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'analysis_screen.dart';
import 'cubit/cb_analysis_screen.dart';

class AnalysisScreenProvider extends StatelessWidget {
  const AnalysisScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbAnalysisScreen>(
      create: (context) => CbAnalysisScreen(),
      child: const AnalysisScreen(),
    );
  }
}    
    