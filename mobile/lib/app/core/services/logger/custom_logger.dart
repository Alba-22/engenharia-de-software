import 'dart:developer' as dev;
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'logger_service.dart';

class CustomLogger implements LoggerService {
  @override
  Future<void> init() async {
    Isolate.current.addErrorListener(isolateErrorListener);
  }

  @override
  Future<void> log(String message) async {
    if (!kReleaseMode) {
      dev.log("CrashServices Log: $message");
    }
    // ENVIO DA MENSAGEM DE LOG
  }

  @override
  Future<void> recordError(exception, StackTrace? stackTrace) async {
    if (!kReleaseMode) {
      dev.log("Exception: ${exception.toString()}");
      dev.log("StackTrace: ${stackTrace.toString()}");
    }
    if (exception != null) {
      // ENVIO DA MENSAGEM DE ERRO
    }
  }

  @override
  SendPort get isolateErrorListener {
    return RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      final exception = errorAndStacktrace.first;
      final stackTrace = errorAndStacktrace[1];
      recordError(exception, stackTrace);
    }).sendPort;
  }
}
