abstract class StRegistrationScreen{}

class StRegistrationScreenInit extends StRegistrationScreen{}

class StRegistrationScreenLoaded extends StRegistrationScreen{}

class StRegistrationScreenAuthed extends StRegistrationScreen{}

class StRegistrationScreenLoading extends StRegistrationScreen{}

class StRegistrationScreenNoAuthError extends StRegistrationScreen{}

class StRegistrationScreenNoInternetError extends StRegistrationScreen {}

class StRegistrationScreenError extends StRegistrationScreen{
  final int? error;
  final String? message;
  StRegistrationScreenError({this.error,this.message});
}
class StSuccessLogin extends StRegistrationScreen {}

class StMailErrorMessage extends StRegistrationScreen {
  final String? errMessage;
  StMailErrorMessage({this.errMessage});
}