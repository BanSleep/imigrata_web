import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/screens/payment_screen/payment_screen_provider.dart';

import 'st_registration_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:get/get.dart';
import 'dart:convert';

class CbRegistrationScreen extends Cubit<StRegistrationScreen> {
  CbRegistrationScreen() : super(StRegistrationScreenLoaded());
  
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StRegistrationScreenLoaded());
    } on APIException catch (e) {
      emit(StRegistrationScreenError(error: e.code));
    }
  }

  Future<void> getLoaded() async {
    try {
      emit(StRegistrationScreenLoaded());
    } on APIException catch (e) {
      emit(StRegistrationScreenError(error: e.code));
    }
  }
  Future<void> register(String name, String email, String phone, String password) async {
    try {
      emit(StRegistrationScreenLoading());
      Map<String, dynamic> response = await Api.post(method: 'users/register', body: {
        'name': name,
        'email': email,
        'password': password
      }, testMode: true);
      emit(StSuccessLogin());
    } on APIException catch (error) {
      if (error.code >= 400 && error.code < 500) {
        Map value = json.decode(error.body);
        emit(StMailErrorMessage(errMessage: value['message']));
      } else if (error.code == 0) {
        emit(StSuccessLogin());
      } else if (error.code == 201) {
        emit(StSuccessLogin());
      }
      else if (error.code == 500) {
        emit(StRegistrationScreenError());
      }
    }
  }
  Future<void> login(String email, String password) async {
    try {
      emit(StRegistrationScreenLoading());
      Map<String, dynamic> response = await Api.post(method: 'users/login', body: {
        'email': email,
        'password': password
      }, testMode: true);
      Api.setToken(response['token']);
      emit(StRegistrationScreenAuthed());
    } on APIException catch (error) {
      if (error.code == 0) {
        emit(StRegistrationScreenNoInternetError());
      } else if (error.code >= 500) {
        emit(StRegistrationScreenError(error: error.code));
      } else if (error.code >= 400 && error.code < 500) {
        Map value = json.decode(error.body);
        emit(StMailErrorMessage(errMessage: value['message']));
      }

    }
  }
}
    