// ------------------ OrderConfirmationScreen.dart ------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Color mainRed = const Color(0xFFFF4B2B);
  final Color mainPink = const Color(0xFFFF416C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ------------------ APP BAR ------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Taller AppBar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [mainRed, mainPink]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Order Confirmed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      // ------------------ BODY ------------------
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon with shadow
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_circle,
                size: 120,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 50),

            const Text(
              "Order Placed Successfully!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            const Text(
              "Thank you for your order.\nYour meal is being prepared!",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 60),

            // ------------------ Gradient Confirm Button ------------------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: InkWell(
                onTap: () => Get.offAllNamed(AppRoutes.home),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [mainRed, mainPink]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
