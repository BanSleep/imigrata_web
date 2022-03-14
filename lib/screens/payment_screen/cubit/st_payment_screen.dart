abstract class StPaymentScreen{}

class StPaymentScreenInit extends StPaymentScreen{}

class StPaymentScreenLoaded extends StPaymentScreen{}

class StPaymentScreenLoading extends StPaymentScreen{}

class StPaymentScreenNoAuthError extends StPaymentScreen{}

class StPaymentScreenNoInternetError extends StPaymentScreen {}

class StPaymentScreenError extends StPaymentScreen{
  final int? error;
  final String? message;
  StPaymentScreenError({this.error,this.message});
}
    