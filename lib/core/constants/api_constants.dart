class ApiConstants {
  const ApiConstants._();

  static const String jsonMimeType = 'application/json';

  static const String acceptHeader = 'accept';
  static const String contentTypeHeader = 'content-type';
  static const String authorizationHeader = 'Authorization';

  static const String authLogin = '/auth/login';
  static const String products = '/products';
  static const String searchProducts = '/products/search';

  static const String skipQuery = 'skip';
  static const String limitQuery = 'limit';
  static const String searchQuery = 'q';

  static const int productsPerPage = 20;
}
