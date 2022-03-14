import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/project_utils/pj_const.dart';

import 'st_payment_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbPaymentScreen extends Cubit<StPaymentScreen> {
  CbPaymentScreen() : super(StPaymentScreenLoaded());
  
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StPaymentScreenLoaded());
    } on APIException catch (e) {
      emit(StPaymentScreenError(error: e.code));
    }
  }
  Future<void> getLoaded() async {
    try {
      emit(StPaymentScreenLoaded());
    } on APIException catch (e) {
      emit(StPaymentScreenError(error: e.code));
    }
  }
  Future<void> pay() async {
    try {
      // log(GetStorage().read(PjConst.SESSION_ID).toString(), name: "sessionId");
      Map<String, dynamic> response = await Api.post(method: 'payment/intent', body: {
        'sessionId': GetStorage().read(PjConst.SESSION_ID),
        'amount': 1,
        'currency': "usd",
      },testMode: true);
      GetStorage().write('pubKey', response['publishable']);
      GetStorage().write('clientSecret', response['clientSecret']);
    } on APIException catch (error) {
      emit(StPaymentScreenError());
    }
  }
}
    