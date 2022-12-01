class ApiEndPoints {
  ApiEndPoints._();
  static bool isInitialised = false;

    // static String baseUrl = 'https://consumerapp.livesorted.com';
 static String baseUrl = 'https://consumerapp-dev.livesorted.com';
  static String createUser = '/auth/user/create';
  static String sendOtp = '/auth/otp';
  static String verifyOtp = '/auth/verify-otp';
  static String consumer = '/api/rest/consumer';
  static String profileUpdate = '/auth/user';
  static String addresses = '/auth/addresses';
  static String refresh = '/auth/refresh';
  static String deviceDetails = '/device-details';
  static String storeInventory = '/store-app/inventory/v2';
  static String offeres = '/offers/fetch';
  static String autoComplete = '/util/geo/auto-complete';
  static String geoAddress = '/util/geo/address';
  static String geoCoordinates = '/util/geo/cordinates';
  static String initConfig = '/util/config/get/mobile';
  static String cartSummary = '/orders/cart';
  static String createOrder = '/orders/cart/submit';
  static String storeNearMe = '/store-app/store/nearme';
  static String orderList = '/orders/customer';
  static String personalMatters = '/orders/customer/personalmatters';
  static String orderDetails = '/orders';
  static String trackOrder = '/track';
  static String applyOffer = '/orders/cart/apply-offer';
  static String removeOffer = '/orders/cart/remove-offer';
  static String pendingOrders = '/orders/customer/pending';
  static String logOut = '/auth/logout';
  static String deleteAccount = '/auth/user/delete';
  static String initiatePayment = '/payments/initiate/razorpay';
  static String authenticatePayment = '/payments/confirm/razorpay';
}
