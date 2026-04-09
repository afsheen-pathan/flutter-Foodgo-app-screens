import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnim = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.1, -1),
            end: Alignment(0.0, 1),
            colors: [Color(0xFFFF939B), Color(0xFFEF2A39)],
          ),
        ),
        child: Stack(
          children: [
            // Decorative pill left
            Positioned(
              left: -26,
              bottom: 110,
              child: Container(
                width: 57,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),
            // Large burger bottom-left (image 2)
            Positioned(
              bottom: 0,
              left: -30,
              child: Image.asset(
                AppImages.image2,
                width: 240,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            // Smaller burger bottom-right (image 6)
            Positioned(
              bottom: 10,
              right: 10,
              child: Image.asset(
                AppImages.image6,
                width: 190,
                height: 190,
                fit: BoxFit.contain,
              ),
            ),
            // Logo centered
            Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Foodgo',
                      style: TextStyle(
                        fontSize: 62,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
