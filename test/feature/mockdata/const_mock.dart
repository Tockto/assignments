import 'package:assignments/core/error/exception.dart';
import 'package:assignments/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class ConstMock {
  static const serverFailure = Left(ServerFailure("server crash"));
  static const cacheFailure = Left(CacheFailure("not found data"));
  static ServerException serverException = ServerException("server crash");
  static CacheException cacheException = CacheException("not found data");
}
