class APIErrors implements Exception {
  List<APIError> errors;

  APIErrors.fromJson(Map<String, dynamic> json) {
    errors = new List<APIError>();
    if (json['error'] != null) {
      // TODO: недокументировано
      errors.add(APIError.fromJson(json['error']));
    }
    if (json['errors'] != null) {
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

  String toText() {
    var messages = errors.map((e) => e.toText());
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

  String toText() {
    return description;
  }
}
