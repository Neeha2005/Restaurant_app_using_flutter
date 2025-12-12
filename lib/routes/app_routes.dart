import 'package:get/get.dart';
import '../views/splash_screen.dart';
import '../views/login_screen.dart';
import '../views/signup_screen.dart';
import '../views/home_screen.dart';
import '../views/cart_screen.dart';
import '../views/checkout_screen.dart';
import '../views/order_confirm_screen.dart';
import '../views/welcome_screen.dart'; // ✔ add this

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orderConfirmation = '/order_confirmation';
  static const welcome = '/welcome';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignUpScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: cart, page: () => CartScreen()),
    GetPage(name: checkout, page: () => CheckoutScreen()),
    GetPage(name: orderConfirmation, page: () => OrderConfirmationScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()), // ✔ now valid
  ];
}
