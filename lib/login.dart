import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const JeevRakshaApp());
}

class JeevRakshaApp extends StatelessWidget {
  const JeevRakshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JeevRaksha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF008080)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LandingPage(),
    );
  }
}

// --- 1. LANDING PAGE (CAROUSEL + 3 BUTTONS) ---
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _pageController;
  int _fakePageIndex = 1000;
  Timer? _timer;

  final List<String> images = [
    "assets/images/pexels-adityasanjay97-2579504.jpg",
    "assets/images/pexels-delot-31440990.jpg",
    "assets/images/pexels-mohammed-asaad-896403946-28543974.jpg",
    "assets/images/pexels-tamhasipkhan-6601811.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _fakePageIndex);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _pageController.hasClients) {
        _fakePageIndex++;
        _pageController.animateToPage(
          _fakePageIndex,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int actualIndex = _fakePageIndex % images.length;

    return Scaffold(
      body: Stack(
        children: [
          // Infinite Background Carousel
          SizedBox.expand(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _fakePageIndex = index),
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index % images.length],
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken,
                );
              },
            ),
          ),

          // Content Layer
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Icon(Icons.pets, size: 80, color: Colors.white),
                const Text(
                  'JEEVRAKSHA',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3),
                ),
                const Text(
                  'CARE FOR ANIMALS ANYTIME',
                  style: TextStyle(color: Colors.white70, letterSpacing: 1.5),
                ),

                const SizedBox(height: 20),

                // Animated Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: actualIndex == i ? 24 : 8,
                    decoration: BoxDecoration(
                      color: actualIndex == i ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ),

                const Spacer(),

                // The Three Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _buildButton(context, "LOG IN", Colors.white, const Color(0xFF008080),
                              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()))),
                      const SizedBox(height: 15),
                      _buildButton(context, "SIGN UP", Colors.white.withOpacity(0.2), Colors.white,
                              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage())), border: true),
                      const SizedBox(height: 40),

                      // Emergency Button (No Auth Required)
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton.icon(
                          onPressed: () => _handleEmergency(context),
                          icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                          label: const Text("EMERGENCY HELP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color bg, Color textCol, VoidCallback onTap, {bool border = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          side: border ? const BorderSide(color: Colors.white, width: 1.5) : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(text, style: TextStyle(color: textCol, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _handleEmergency(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Urgent Report"),
      content: const Text("Witnessing animal cruelty? Report now without login."),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Back")),
        FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: Colors.red), child: const Text("Confirm SOS"))],
    ));
  }
}

// --- 2. SIGN UP PAGE (SEPARATE FORM) ---
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildField('Full Name', Icons.person_outline),
            const SizedBox(height: 16),
            _buildField('Email', Icons.email_outlined),
            const SizedBox(height: 16),
            _buildField('Phone Number', Icons.phone_android_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            _buildField('Password', Icons.lock_outline, isPassword: true),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, height: 55,
                child: FilledButton(onPressed: () {}, child: const Text('SIGN UP'))),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// --- 3. LOGIN PAGE (PHONE & GOOGLE) ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: const Icon(Icons.phone), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: FilledButton(onPressed: () {}, child: const Text('GET OTP'))),
            const SizedBox(height: 40),
            const Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("OR")), Expanded(child: Divider())]),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata, size: 35),
              label: const Text("Continue with Google"),
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            ),
          ],
        ),
      ),
    );
  }
}