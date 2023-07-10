import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  void login() {
    isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    isAuthenticated = false;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'White App Bar',
        theme: ThemeData(
          primaryColor: Colors.white, // Set the primary color to white
        ),
        home: HomePage(),
      ),
    );
  }
}
