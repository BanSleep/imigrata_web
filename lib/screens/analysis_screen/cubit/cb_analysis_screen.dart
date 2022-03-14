import 'st_analysis_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbAnalysisScreen extends Cubit<StAnalysisScreen> {
  CbAnalysisScreen() : super(StAnalysisScreenLoaded());
  
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StAnalysisScreenLoaded());
    } on APIException catch (e) {
      emit(StAnalysisScreenError(error: e.code));
    }
  }
}
    