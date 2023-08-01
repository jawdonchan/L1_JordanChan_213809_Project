import 'package:flutter/material.dart';
import 'package:proj_layout/screen/prompt.dart';
import 'screen/home.dart';
import 'package:provider/provider.dart';
import 'package:proj_layout/bus/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white, // Set the primary color to white
        ),
        home: PromptPage(),
      ),
    );
  }
}
