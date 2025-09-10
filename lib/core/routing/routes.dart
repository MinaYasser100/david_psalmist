class Routes {
  // Singleton instance
  static final Routes _instance = Routes._internal();

  // Private constructor
  Routes._internal();

  // Factory constructor to return the same instance
  factory Routes() {
    return _instance;
  }

  // Static route constants
  static const String productList = '/';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String signUp = '/set-up';
  static const String checkout = '/checkout';
}
