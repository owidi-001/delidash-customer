// API URL
// const String baseURL = "http://owidi.pythonanywhere.com";
const String baseURL = "http://192.168.0.106:8000";


// Routes for app
class AppRoute {
  static const String splash = "/";

  // auth routes
  static const String welcome = "/welcome";
  static const String register = "/register";
  static const String login = "/login";

  // Dashboard,list,detail routes
  static const String home = "/home";
  static const String dashboard = "/dashboard";
  static const String location = "/location";
  static const String productList = "/foods";
  static const String productDetail = "/food_detail";

  // cart routes
  static const String cart = "/cart";
  static const String checkout = "/checkout";

  // profile, update
  static const String profile = "/profile";
  static const String profileEdit = "/profileEdit";
}

class ApiUrl {
  // user auth
  static const String login = "$baseURL/auth/login/";
  static const String register = "$baseURL/auth/register/";

  static const String profileUpdate = "$baseURL/auth/profile/";

  static const String forgotPassword = "$baseURL/forgot-password";

  // User
  // Saved addresses
  static const String userAddress = "$baseURL/orders/address";

  
  // orders
  // static const String orders = "$baseURL/orders/orders";
  static const String orders = "$baseURL/orders";
  static const String orderItems = "$baseURL/orders/items";
  static const String payment = "$baseURL/payment";
  
  // feedback
  static const String feedback = "$baseURL/orders/feedback";

  // Vendors
  static const String listVendors = "$baseURL/vendors";

  // products
  static const String listProducts = "$baseURL/products/products/";

  static const String listCategories = "$baseURL/products/categories/";
}
