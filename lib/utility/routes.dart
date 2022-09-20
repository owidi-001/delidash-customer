import 'package:greens_veges/utility/constants.dart';

class MyRoutes {
  // auth routes
  static const String welcome = "/welcome";
  static const String register = "/register";
  static const String login = "/login";

  // Dashboard,list,detail routes
  static const String dashboardRoute = "/dashboard";
  static const String foodListRoute = "/foods";
  static const String foodDetailRoute = "/food_detail";
  // cart routes
  static const String cartRoute = "/cart";
  // profile, history
  static const String profileRoute = "/profile";
  static const String profileEditRoute = "/profileEdit";
}


class AppUrl {

  // user auth
  static const String login = "$baseURL/auth/login/";
  static const String register = "$baseURL/auth/register/";
  static const String forgotPassword = "$baseURL/forgot-password";

  // products
  static const String listProducts = "$baseURL/product/";

  static const String listCategories = "$baseURL/categories/";

  // order
  static const String placeOrder = "$baseURL/order/";

}