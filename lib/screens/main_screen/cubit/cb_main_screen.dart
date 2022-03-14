import 'st_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(StMainScreenLoaded());
  
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StMainScreenLoaded());
    } on APIException catch (e) {
      emit(StMainScreenError(error: e.code));
    }
  }
}
    