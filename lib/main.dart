import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gluten_check/LoginPage/login.dart';
import 'package:gluten_check/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GlutenScanner());
}

class GlutenScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlutenCheck',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 223, 209, 189),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 223, 209, 189),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge:
              const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge:
              GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: LoginPage(),
    );
  }
}
