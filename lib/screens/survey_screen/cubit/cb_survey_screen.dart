import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/models/form_model.dart';
import 'package:imigrata_web/project_utils/pj_const.dart';

import 'st_survey_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbSurveyScreen extends Cubit<StSurveyScreen> {
  CbSurveyScreen() : super(StSurveyScreenInit());

  Future<void> postData(
      {int? formId,
      String? sessionId,
      String? text,
      int? number,
      String? dropdown,
      String? choice,
      List<String>? multipleSelection}) async {
    Map<String, dynamic> body = //{};
    {"formName": "Aimfly onboarding"};
    if (formId != null &&
        text != null &&
        number == null &&
        dropdown == null &&
        choice == null &&
        multipleSelection == null) {
      body = {
        'formId': formId,
        'sessionId': sessionId,
        'value': {'text': text}
      };
    } else if (formId != null &&
        text == null &&
        number == null &&
        dropdown == null &&
        choice == null &&
        multipleSelection == null) {
      body = {'formId': formId, 'sessionId': sessionId};
    } else if (formId != null &&
        number != null &&
        text == null &&
        dropdown == null &&
        choice == null &&
        multipleSelection == null) {
      body = {
        'formId': formId,
        'sessionId': sessionId,
        'value': {'number': number}
      };
    } else if (formId != null &&
        number == null &&
        text == null &&
        dropdown != null &&
        choice == null &&
        multipleSelection == null) {
      body = {
        'formId': formId,
        'sessionId': sessionId,
        'value': {'dropdown': dropdown}
      };
    } else if (formId != null &&
        number == null &&
        text == null &&
        dropdown == null &&
        choice != null &&
        multipleSelection == null) {
      body = {
        'formId': formId,
        'sessionId': sessionId,
        'value': {'choice': choice}
      };
    } else if (formId != null &&
        number == null &&
        text == null &&
        dropdown == null &&
        choice == null &&
        multipleSelection != null) {
      body = {
        'formId': formId,
        'sessionId': sessionId,
        'value': {'multipleSelection': multipleSelection}
      };
    }

    try {
      // emit(StSurveyScreenLoading());
      Map<String, dynamic> response = await Api.post(
        method: 'form',
        testMode: true,
        body: body,
      );
      // log('${response}');
      FormModel formModel = FormModel.fromJson(response);

      // GetStorage().remove(PjConst.SESSION_ID);
      // GetStorage().remove(PjConst.FORM_ID);
      GetStorage().write(PjConst.SESSION_ID, response['sessionId']);
      GetStorage().write(PjConst.FORM_ID, response['formId']);

      if (response['formType'] != 'end') {
        // emit(StSurveyScreenError());
        emit(StSurveyScreenLoaded(formModel: formModel));
      } else {
        emit(StSurveyScreenEnd());
      }
    } on APIException catch (e) {
      log('${e.code}', name: 'Error');
      log('${e.body}', name: 'Error');
      if (e.code == 0) {
        emit(StSurveyScreenNoInternetError());
      } else {
        emit(StSurveyScreenError(error: e.code));
      }
    }
  }

  Future<void> getData() async {
    Map<String, dynamic> query = {
      'sessionId': GetStorage().read(PjConst.SESSION_ID),
      'formId': GetStorage().read(PjConst.FORM_ID),
      'delta': -1,
    };
    try {
      // emit(StSurveyScreenLoading());
      Map<String, dynamic> response = await Api.get(
        method: 'form',
        testMode: true,
        query: query,
      );
      // log('${response}');
      FormModel formModel = FormModel.fromJson(response);

      GetStorage().write(PjConst.SESSION_ID, response['sessionId']);
      GetStorage().write(PjConst.FORM_ID, response['formId']);


      if (response['formType'] != 'end') {
        emit(StSurveyScreenLoaded(formModel: formModel));
      } else {
        emit(StSurveyScreenEnd());
      }
    } on APIException catch (e) {
      log('${e.code}', name: 'Error');
      log('${e.body}', name: 'Error');
      if (e.code == 0) {
        emit(StSurveyScreenNoInternetError());
      } else {
        emit(StSurveyScreenError(error: e.code));
      }
    }
  }
}
