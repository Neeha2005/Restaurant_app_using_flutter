import 'package:get/get.dart';

class AuthController extends GetxController {
  // Hardcoded user for login
  final String hardcodedUser = "admin";
  final String hardcodedPass = "12345";

  // List to store signed up users locally (in RAM)
  var registeredUsers = <Map<String, String>>[].obs;

  // Login function
  bool login(String username, String password) {
    // Check hardcoded user
    if (username == hardcodedUser && password == hardcodedPass) {
      return true;
    }

    // Check local registered users
    for (var user in registeredUsers) {
      if (user["username"] == username && user["password"] == password) {
        return true;
      }
    }

    return false;
  }

  // Sign up function
  bool signup(String username, String password) {
    // Basic validation
    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    // Prevent duplicate usernames
    for (var user in registeredUsers) {
      if (user["username"] == username) {
        return false;
      }
    }

    registeredUsers.add({"username": username, "password": password});
    return true;
  }
}
