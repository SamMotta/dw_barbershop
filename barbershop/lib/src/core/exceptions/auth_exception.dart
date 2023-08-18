sealed class BaseAuthException implements Exception {
  BaseAuthException({required this.message});

  final String message;
}

class AutheticationException extends BaseAuthException {
  AutheticationException({required super.message});
}

class UnauthorizedException extends BaseAuthException {
  UnauthorizedException() : super(message: '');
}
