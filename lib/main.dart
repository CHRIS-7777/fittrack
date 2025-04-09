import 'package:fitrack/pages/datapage.dart';
import 'package:fitrack/pages/foodpage.dart';
import 'package:fitrack/pages/homepage.dart';
import 'package:fitrack/pages/lowerpage1.dart';
import 'package:fitrack/pages/lowerpage2.dart';
import 'package:fitrack/pages/lowerpage3.dart';
import 'package:fitrack/pages/lowerpage4.dart';
import 'package:fitrack/pages/lowerpage5.dart';
import 'package:fitrack/pages/lowerpage6.dart';
import 'package:fitrack/pages/tutorial.dart';
import 'package:fitrack/pages/upperpage1.dart';
import 'package:fitrack/pages/upperpage2.dart';
import 'package:fitrack/pages/upperpage3.dart';
import 'package:fitrack/pages/upperpage4.dart';
import 'package:fitrack/pages/upperpage5.dart';
import 'package:fitrack/pages/upperpage6.dart';
import 'package:fitrack/pages/workout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyD7zAT0YL3e4mnvbdViXlSGNHNwWG3F95A',
      appId: '1:433740360780:android:5f87c9c69e483a863b18e9',
      messagingSenderId: '433740360780',
      projectId: 'fitrack-d98e6',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashscreen', // Set initial route
      routes: {
        '/home': (context) => Homee(),
        '/tutorialPage': (context) => TutorialPage(),
        '/splashscreen': (context) => SplashScreen(),
        '/upper1': (context) => upperpage1(),
        '/workoutPage': (context) => WorkoutPage(),
      '/upper2': (context) =>upperpage2(),
      '/upper3': (context) => upperpage3(),
      '/upper4': (context) => upperpage4(),
      '/upper5': (context) => upperpage5(),
      '/upper6': (context) =>upperpage6(),
      '/lower1': (context) => lowerpage1(),
      '/lower2': (context) =>lowerpage2(),
      '/lower3': (context) => lowerpage3(),
      '/lower4': (context) =>lowerpage4(),
      '/lower5': (context) => lowerpage5(),
      '/lower6': (context) => lowerpage6(),
      '/foodpage':(context) =>Food_Page(),
      '/dataPage': (context) => DataPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF7A7A7A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gyy.png', height: 150),
              SizedBox(height: 20),
              Text("FitRack..",
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homee()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect username")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF7A7A7A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/gyy.png', height: 120),
                  SizedBox(height: 10),
                  Text("Log in", style: TextStyle(color: Colors.white, fontSize: 28)),
                  SizedBox(height: 50),
                  _buildTextField("Enter your email", emailController, icon: Icons.email),
                  SizedBox(height: 15),
                  _buildTextField("Enter your password", passwordController, icon: Icons.lock, isPassword: true),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    ),
                    onPressed: login,
                    child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())),
                    child: Text("Not a member? Register now", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homee()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Type valid username")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), backgroundColor: Colors.black),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF7A7A7A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/gyy.png', height: 120),
                  SizedBox(height: 10),
                  Text("Register Now", style: TextStyle(color: Colors.white, fontSize: 28)),
                  SizedBox(height: 50),
                  _buildTextField("Enter your email", emailController, icon: Icons.email),
                  SizedBox(height: 15),
                  _buildTextField("Enter your password", passwordController, icon: Icons.lock, isPassword: true),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    ),
                    onPressed: register,
                    child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget _buildTextField(String hintText, TextEditingController controller,
    {bool isPassword = false, IconData? icon}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white70),
      filled: true,
      // ignore: deprecated_member_use
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
    ),
  );
}
