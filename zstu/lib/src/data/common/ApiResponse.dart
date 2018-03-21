class ApiResponse {
  ApiResponse.fromMap(Map<String, dynamic> map) {
    count = map["count"];
    items = map["items"];
  }

  int count;

  List<dynamic> items;
}