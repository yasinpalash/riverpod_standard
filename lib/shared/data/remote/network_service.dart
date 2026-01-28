


abstract class NetworkService {
  String get baseUrl;
  Map<String, Object> get headers;
  void updateHeader(Map<String, dynamic> data);
}