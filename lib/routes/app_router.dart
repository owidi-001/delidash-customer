// API URL
const String baseURL = "http://owidi.pythonanywhere.com";

// Routes for app
class AppRoute{
  static const String splash = "/";

  // auth routes
  static const String welcome = "/welcome";
  static const String register = "/register";
  static const String login = "/login";

  // Dashboard,list,detail routes
  static const String home = "/home";
  static const String dashboard = "/dashboard";
  static const String productList = "/foods";
  static const String productDetail = "/food_detail";

  // cart routes
  static const String cart = "/cart";

  // profile, update
  static const String profile = "/profile";
  static const String profileEdit = "/profileEdit";
}


class ApiUrl{
  // user auth
  static const String login = "$baseURL/auth/login/";
  static const String register = "$baseURL/auth/register/";
  static const String profileUpdate = "$baseURL/auth/profile/"; // Update profile 
  static const String forgotPassword = "$baseURL/forgot-password";

  // Vendors
  static const String listVendors = "$baseURL/vendor/vendors/";

  // products
  static const String listProducts = "$baseURL/product/";

  static const String listCategories = "$baseURL/categories/";

  // order
  static const String placeOrder = "$baseURL/order/";

}