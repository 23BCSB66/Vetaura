import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/app_colors.dart';
import 'sos_success_screen.dart';

class SosRoutingScreen extends StatefulWidget {
  const SosRoutingScreen({super.key});

  @override
  State<SosRoutingScreen> createState() => _SosRoutingScreenState();
}

class _SosRoutingScreenState extends State<SosRoutingScreen> {
  String _statusMessage = 'Fetching your location...';
  double _progress = 0.2;

  @override
  void initState() {
    super.initState();
    _startMockRouting();
  }

  void _startMockRouting() async {
    // 1. Fetching location
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _statusMessage = 'Analyzing emergency...';
      _progress = 0.5;
    });

    // 2. Finding nearest NGO
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _statusMessage = 'Routing to nearest verified NGO...';
      _progress = 0.8;
    });

    // 3. Success
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _progress = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SosSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pulse animation container
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.emergency,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
