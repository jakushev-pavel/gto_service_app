class Errors implements Exception {
  List<APIError> errors;

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = new List<APIError>();
      json['errors'].forEach((v) {
        errors.add(APIError.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    var messages = errors.map((e) => e.toString());
    return messages.join(", ");
  }
}

class APIError {
  String type;
  String description;

  APIError.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
  }

  String toString() {
    return "$type: $description";
  }
}