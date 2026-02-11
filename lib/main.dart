import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RumDOUL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppin',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _letterR;
  late Animation<Offset> _letteru;
  late Animation<Offset> _letterm;
  late Animation<Offset> _letterD;
  late Animation<Offset> _letterO;
  late Animation<Offset> _letterU;
  late Animation<Offset> _letterL;
  late Animation<double> _subtitleFadeAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _backgroundColorAnimation =
        ColorTween(
          begin: const Color(0xFF0A0E18),
          end: const Color(0xFF1A1F38),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
          ),
        );

    _logoSlideAnimation =
        Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.25, curve: Curves.easeOutCubic),
          ),
        );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    _letterR = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.15, 0.35, curve: Curves.easeOutCubic),
          ),
        );

    _letteru = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.42, curve: Curves.easeOutCubic),
          ),
        );

    _letterm = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.32, 0.49, curve: Curves.easeOutCubic),
          ),
        );

    _letterD = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.39, 0.56, curve: Curves.easeOutCubic),
          ),
        );

    _letterO = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.46, 0.63, curve: Curves.easeOutCubic),
          ),
        );

    _letterU = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.53, 0.70, curve: Curves.easeOutCubic),
          ),
        );

    _letterL = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.60, 0.77, curve: Curves.easeOutCubic),
          ),
        );

    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Timer(const Duration(milliseconds: 4000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 1000),
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    final logoSize = isMobile ? 60.0 : 90.0;
    final letterSize = isMobile ? 32.0 : 50.0;
    final subtitleSize = isMobile ? 9.0 : 12.0;

    return AnimatedBuilder(
      animation: _backgroundColorAnimation,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _backgroundColorAnimation.value!,
                  _backgroundColorAnimation.value!.withOpacity(0.95),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 0.03 + (_controller.value * 0.02),
                        child: CustomPaint(
                          painter: _ShimmerPainter(
                            time: _controller.value * 1000,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _logoSlideAnimation,
                            child: FadeTransition(
                              opacity: _logoFadeAnimation,
                              child: SizedBox(
                                width: logoSize,
                                height: logoSize,
                                child: Image.asset(
                                  'assets/flower.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: _letterR,
                            child: _buildLetter('R', letterSize),
                          ),
                          SlideTransition(
                            position: _letteru,
                            child: _buildLetter('u', letterSize),
                          ),
                          SlideTransition(
                            position: _letterm,
                            child: _buildLetter('m', letterSize),
                          ),
                          SlideTransition(
                            position: _letterD,
                            child: _buildLetter('D', letterSize),
                          ),
                          SlideTransition(
                            position: _letterO,
                            child: _buildLetter('O', letterSize),
                          ),
                          SlideTransition(
                            position: _letterU,
                            child: _buildLetter('U', letterSize),
                          ),
                          SlideTransition(
                            position: _letterL,
                            child: _buildLetter('L', letterSize),
                          ),
                        ],
                      ),
                      FadeTransition(
                        opacity: _subtitleFadeAnimation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFC9A66B).withOpacity(0.1),
                                const Color(0xFFD4B483).withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFC9A66B).withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            'KINGDOM OF WONDER',
                            style: TextStyle(
                              color: const Color(0xFFD4B483),
                              fontSize: subtitleSize,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppin',
                              letterSpacing: isMobile ? 2 : 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLetter(String letter, double fontSize) {
    return Text(
      letter,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        fontFamily: 'PlayfairDisplay',
        letterSpacing: 0,
        height: 1.2,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
          Shadow(
            color: const Color(0xFFC9A66B).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final double time;

  _ShimmerPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFC9A66B).withOpacity(0.1),
              Colors.transparent,
            ],
            stops: const [0.0, 0.8],
          ).createShader(
            Rect.fromCircle(
              center: Offset(
                size.width * 0.5 + 100 * sin(time * 0.01),
                size.height * 0.5 + 100 * cos(time * 0.01),
              ),
              radius: 300,
            ),
          );

    canvas.drawCircle(
      Offset(
        size.width * 0.5 + 100 * sin(time * 0.01),
        size.height * 0.5 + 100 * cos(time * 0.01),
      ),
      300,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter oldDelegate) {
    return time != oldDelegate.time;
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // BACKGROUND IMAGE
          Image.asset(
            'assets/Cambodia.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A0E18),
                      Color(0xFF1A1F38),
                      Color(0xFF2D344F),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              );
            },
          ),

          // DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.35)),

          // CONTENT
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and name at TOP
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: Image.asset(
                            'assets/flower.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RumDOUL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'PlayfairDisplay',
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              'KINGDOM OF WONDER',
                              style: TextStyle(
                                color: const Color(0xFFD4B483),
                                fontSize: 8,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppin',
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 34),

                    // Main content in the MIDDLE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CAMBODIA\nEXPLORE\nDISCOVER\nTRAVEL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            letterSpacing: 2.5,
                            fontFamily: 'Poppin',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Description text - first part
                        Text(
                          'Your experiences destinations start here.Enjoy\nyour best experience holiday.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.80),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            letterSpacing: 0.3,
                            fontFamily: 'Poppin',
                          ),
                        ),

                        const SizedBox(height: 10),

                        // "Let this app guide you:" - BIGGER and separate
                        Text(
                          'Let this app guide you !!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            fontFamily: 'Poppin',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 170),
                    // Get Started button at BOTTOM
                    Center(
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB8860B),
                              Color(0xFFDAA520),
                              Color(0xFFFFD700),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDAA520).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black87,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
