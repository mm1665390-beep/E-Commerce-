
import 'package:ecommerce/core/errors/exception.dart';
import 'package:ecommerce/core/errors/failure.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is ServerException) {
    return ServerFailure();
  } else if (e is OfflineException) {
    return OfflineFailure();
  } else if (e is EmptyCacheException) {
    return EmptyCacheFailure();
  } else {
    return UnknownFailure();
  }
}
