import 'models/rest_client_response.dart';

abstract class RestClientService {
  // Content Types values
  static const jsonContentType = 'application/json; charset=utf-8';
  static const formUrlEncodedContentType = 'application/x-www-form-urlencoded';
  static const textPlainContentType = 'text/plain';
  static const multipartFormData = 'multipart/form-data';

  RestClientService auth();
  RestClientService unauth();
  RestClientService simple();

  Future<RestClientResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });

  Future<RestClientResponse<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });

  Future<RestClientResponse<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });

  Future<RestClientResponse<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });

  Future<RestClientResponse<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });

  Future<RestClientResponse<T>> request<T>(
    String url, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? contentType,
    RestClientResponseType? responseType,
  });
}

enum RestClientResponseType {
  json,
  stream,
  plain,
  bytes,
}

class HttpStatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int nonAuthoritativeInformation = 203;
  static const int noContent = 204;
  static const int resetContent = 205;
  static const int partialContent = 206;
  static const int multiStatus = 207;
  static const int alreadyReported = 208;
  static const int imUsed = 226;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int paymentRequired = 402;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotFound = 405;
  static const int notAcceptable = 406;
  static const int proxyAuthenticationRequired = 407;
  static const int requestTimeout = 408;
  static const int conflict = 409;
  static const int gone = 410;
  static const int lengthRequired = 411;
  static const int preconditionFailed = 412;
  static const int payloadToLarge = 413;
  static const int requestURITooLong = 414;
  static const int unsupportedMediaType = 415;
  static const int requestedRangeNotSatisfiable = 416;
  static const int expectationFailed = 417;
  static const int iamATeapot = 418;
  static const int misdirectedRequest = 421;
  static const int unprocessableEntity = 422;
  static const int locked = 423;
  static const int failedDependency = 424;
  static const int upgradeRequired = 426;
  static const int preconditionRequired = 428;
  static const int tooManyRequests = 429;
  static const int internalServerError = 500;
  static const int notImplemented = 501;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}
