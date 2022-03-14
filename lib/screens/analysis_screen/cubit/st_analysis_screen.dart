abstract class StAnalysisScreen{}

class StAnalysisScreenInit extends StAnalysisScreen{}

class StAnalysisScreenLoaded extends StAnalysisScreen{}

class StAnalysisScreenLoading extends StAnalysisScreen{}

class StAnalysisScreenNoAuthError extends StAnalysisScreen{}

class StAnalysisScreenNoInternetError extends StAnalysisScreen {}

class StAnalysisScreenError extends StAnalysisScreen{
  final int? error;
  final String? message;
  StAnalysisScreenError({this.error,this.message});
}
    