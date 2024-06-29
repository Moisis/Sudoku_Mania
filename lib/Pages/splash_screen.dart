import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _shiftAnimation;
  late Animation<double> _screenFadeOutAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );

    // Define the animation curve for fade-out
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Define the animation for shifting the overlay image
    _shiftAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.4), // Adjust the shift amount as needed (upward shift)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Define the animation for fading out the entire screen
    _screenFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.8, 1.0, // Fade out at the end of the animation
          curve: Curves.easeOut,
        ),
      ),
    );

    // Start animations
    _animationController.forward();

    // Navigate to home page after animations complete
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/home_page');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _screenFadeOutAnimation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image filling the whole screen with fade effect
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Image(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            // Overlay image stacked on top with shifting animation
            AnimatedPositioned(
              duration: const Duration(seconds: 2), // Adjust the duration as needed
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _shiftAnimation,
                child: Image.asset('assets/icons/appicon.png', scale: 2,),
              ),
            ),
            // Additional widgets can be added here if needed
          ],
        ),
      ),
    );
  }
}
