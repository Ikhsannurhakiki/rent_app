class RegisterResponse {
  final bool error;
  final String message;

  RegisterResponse({required this.error, required this.message});

  /// Creates a [RegisterResponse] object from a JSON map.
  /// This is the manual deserialization method.
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );
  }

  /// Converts a [RegisterResponse] object into a JSON map.
  /// This is the manual serialization method.
  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
    };
  }
}