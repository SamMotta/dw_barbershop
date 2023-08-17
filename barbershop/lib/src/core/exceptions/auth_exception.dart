sealed class BaseAuthException implements Exception {
  final String message;

  BaseAuthException({required this.message});
}

class AutheticationException extends BaseAuthException {
  AutheticationException({required super.message});
}

class UnauthorizedException extends BaseAuthException {
  UnauthorizedException() : super(message: '');
}
