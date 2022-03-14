import 'package:imigrata_web/models/form_model.dart';

abstract class StSurveyScreen{}

class StSurveyScreenInit extends StSurveyScreen{}

class StSurveyScreenLoaded extends StSurveyScreen{
  final FormModel formModel;
  StSurveyScreenLoaded({required this.formModel});
}

class StSurveyScreenEnd extends StSurveyScreen {}

class StSurveyScreenLoading extends StSurveyScreen{}

class StSurveyScreenNoAuthError extends StSurveyScreen{}

class StSurveyScreenNoInternetError extends StSurveyScreen {}

class StSurveyScreenError extends StSurveyScreen{
  final int? error;
  final String? message;
  StSurveyScreenError({this.error,this.message});
}
    