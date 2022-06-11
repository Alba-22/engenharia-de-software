import 'dart:isolate';

abstract class LoggerService {
  Future<void> init();
  Future<void> recordError(dynamic exception, StackTrace? stackTrace);
  Future<void> log(String message);
  SendPort get isolateErrorListener;
}
