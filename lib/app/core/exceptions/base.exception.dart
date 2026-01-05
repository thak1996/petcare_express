abstract class BaseException implements Exception {
  const BaseException(this.message, [this.statusCode]);

  final String message;
  final String? statusCode;

  @override
  String toString() => message;

  String get code => statusCode ?? 'unknown';
}
