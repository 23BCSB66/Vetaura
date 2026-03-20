import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'sos_routing_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late PageController _pageController;
  int _fakePageIndex = 1000;
  Timer? _timer;

  final List<String> images = [
    'assets/images/pexels-adityasanjay97-2579504.jpg',
    'assets/images/pexels-delot-31440990.jpg',
    'assets/images/pexels-mohammed-asaad-896403946-28543974.jpg',
    'assets/images/pexels-tamhasipkhan-6601811.jpg',
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
    final int actualIndex = _fakePageIndex % images.length;

    return Scaffold(
      body: Stack(
        children: [
          // ── Infinite background carousel ──
          SizedBox.expand(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) =>
                  setState(() => _fakePageIndex = index),
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

          // ── Content ──
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Logo + name
                const Icon(Icons.pets, size: 80, color: Colors.white),
                const SizedBox(height: 12),
                const Text(
                  'Vetaura',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'CARE FOR ANIMALS ANYTIME',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 1.8,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                // Carousel dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: actualIndex == i ? 24 : 8,
                      decoration: BoxDecoration(
                        color: actualIndex == i
                            ? Colors.white
                            : Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _PrimaryButton(
                        label: 'LOG IN',
                        bgColor: Colors.white,
                        textColor: const Color(0xFF008080),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _PrimaryButton(
                        label: 'SIGN UP',
                        bgColor: Colors.white.withOpacity(0.2),
                        textColor: Colors.white,
                        border: true,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpScreen()),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Emergency — no auth required
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton.icon(
                          onPressed: () => _showEmergencyDialog(context),
                          icon: const Icon(Icons.warning_amber_rounded,
                              color: Colors.white),
                          label: const Text(
                            'EMERGENCY HELP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
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

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Urgent Report'),
        content: const Text(
            'Witnessing animal cruelty? Report now without logging in.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SosRoutingScreen()),
              );
            },
            style:
                FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Confirm SOS'),
          ),
        ],
      ),
    );
  }
}

// ── Reusable button widget ─────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool border;

  const _PrimaryButton({
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: border
              ? const BorderSide(color: Colors.white, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
