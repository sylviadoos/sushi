import 'dart:convert';

class ResponseMessage {//use it for any response which is not error
  final String message;
  final bool status;
  ResponseMessage({
    required this.message,
    required this.status,
  });

  factory ResponseMessage.fromMap(Map<String, dynamic> map) {
    return ResponseMessage(
      message: map['message'],
      status: map['status'],
    );
  }

  factory ResponseMessage.fromJson(String source) =>
      ResponseMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
