import 'package:firstpro/auth/signin.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _logoScaleAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.repeat();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (Route<dynamic> route) => false,
      );
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated lines
          ...List.generate(10, (index) => _buildAnimatedLine()),

          // Logo with zoom animation
          Center(
            child: ScaleTransition(
              scale: _logoScaleAnimation,
              child: _buildLogoWithCirclingLine(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLine() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LinePainter(progress: _controller.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildLogoWithCirclingLine() {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/logo.jpeg'),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: CircleLinePainter(
                  progress: _controller.value,
                ),
                size: Size.infinite,
              );
            },
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double progress;

  LinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final startPoint = Offset(
      size.width * math.Random().nextDouble(),
      size.height * math.Random().nextDouble(),
    );
    final endPoint = Offset(
      size.width * math.Random().nextDouble(),
      size.height * math.Random().nextDouble(),
    );

    canvas.drawLine(
      startPoint,
      Offset.lerp(startPoint, endPoint, progress)!,
      paint,
    );
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class CircleLinePainter extends CustomPainter {
  final double progress;

  CircleLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      progress * 8 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleLinePainter oldDelegate) => true;
}
