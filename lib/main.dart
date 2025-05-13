import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/services/splash_service.dart';
import 'package:notes/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  bool? isFirstLaunch;

  final splashServices = SplashServices(); //

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    splashServices.isLogin(context);
    print(user?.uid.toString());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: user != null ? HomeScreen() : LoginScreen(),
    );
  }
}
