import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';

void main() {
  // Register controllers before app starts
  Get.put(AuthController());
  Get.put(CartController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      // Start from Splash Screen
      initialRoute: AppRoutes.welcome,

      // All routes
      getPages: AppRoutes.routes,
    );
  }
}
