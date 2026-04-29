import 'package:ap/core/errors/failuremassege.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super(kServerFailureMessage);
}

class OfflineFailure extends Failure {
  OfflineFailure() : super(kOfflineFailureMessage);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure() : super(kCacheFailureMessage);
}

class UnknownFailure extends Failure {
  UnknownFailure() : super(kUnknownFailureMessage);
}
