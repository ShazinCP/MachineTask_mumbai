import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/auth/auth_gate.dart';
import 'package:mumbai_machinetask/controller/auth_controller.dart';
import 'package:mumbai_machinetask/controller/task_controller.dart';
import 'package:mumbai_machinetask/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
