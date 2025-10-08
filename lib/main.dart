import 'dart:math';
import 'package:departmentspg/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(builder: (context) => const MultiColorPopFireflyApp()));
}

class MultiColorPopFireflyApp extends StatelessWidget {
  const MultiColorPopFireflyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiColorPopFireflyScreen(),
    );
  }
}

class MultiColorPopFireflyScreen extends StatefulWidget {
  const MultiColorPopFireflyScreen({super.key});

  @override
  State<MultiColorPopFireflyScreen> createState() =>
      _MultiColorPopFireflyScreenState();
}

class _MultiColorPopFireflyScreenState
    extends State<MultiColorPopFireflyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<GoldFirefly> _fireflies = [];
  final List<PopParticle> _popParticles = [];
  final Random _random = Random();

  final List<Color> _popColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.cyanAccent,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    )
      ..addListener(() {
        updateFireflies();
        updatePopParticles();
      })
      ..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 120; i++) {
        _fireflies.add(GoldFirefly.random(_random, size));
      }
      setState(() {});
    });
  }

  void updateFireflies() {
    final size = MediaQuery.of(context).size;
    for (var f in _fireflies) {
      f.update(size);
    }
    setState(() {});
  }

  void updatePopParticles() {
    for (var p in _popParticles) {
      p.update();
    }
    _popParticles.removeWhere((p) => p.size < 0.5);
  }

  void _onTapDown(TapDownDetails details) {
    final tapPos = details.localPosition;

    for (int i = 0; i < 12; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 1 + _random.nextDouble() * 3;
      _popParticles.add(
        PopParticle(
          position: tapPos,
          velocity: Offset(cos(angle) * speed, sin(angle) * speed),
          size: 4 + _random.nextDouble() * 4,
          color: _popColors[_random.nextInt(_popColors.length)],
        ),
      );
    }

    for (var f in _fireflies) {
      if (_random.nextDouble() < 0.3) {
        f.swirlTo(tapPos);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🔹 Navigate to Next Screen
  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NextScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(225, 11, 1, 53),
      body: GestureDetector(
        onTapDown: _onTapDown,
        child: Stack(
          children: [
            // 🔸 Animated background
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: MultiColorFireflyPainter(_fireflies, _popParticles),
            ),

            // 🔸 Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "#VEDA",
                    style: TextStyle(
                      fontSize: 60,
                      color: Color.fromARGB(255, 196, 206, 245),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 🔸 Get Started Button at Bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginSignupPage(isLoginStart: true)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 242, 238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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

// 🔹 Background Firefly class
class GoldFirefly {
  Offset position;
  Offset velocity;
  double size;
  double opacity;
  final Random random;
  bool swirling = false;
  Offset swirlTarget = Offset.zero;

  GoldFirefly(
      this.position, this.velocity, this.size, this.opacity, this.random);

  factory GoldFirefly.random(Random random, Size screenSize) {
    return GoldFirefly(
      Offset(random.nextDouble() * screenSize.width,
          random.nextDouble() * screenSize.height),
      Offset((random.nextDouble() - 0.5) * 1.2,
          (random.nextDouble() - 0.5) * 1.2),
      2 + random.nextDouble() * 3,
      0.3 + random.nextDouble() * 0.7,
      random,
    );
  }

  void update(Size screenSize) {
    if (swirling) {
      final dir = swirlTarget - position;
      position += dir * 0.05;
      if ((position - swirlTarget).distance < 2) swirling = false;
    } else {
      position += velocity;
      if (position.dx < 0 || position.dx > screenSize.width) {
        velocity = Offset(-velocity.dx, velocity.dy);
      }
      if (position.dy < 0 || position.dy > screenSize.height) {
        velocity = Offset(velocity.dx, -velocity.dy);
      }
    }
    opacity += (random.nextDouble() - 0.5) * 0.04;
    if (opacity < 0.2) opacity = 0.2;
    if (opacity > 1.0) opacity = 1.0;
  }

  void swirlTo(Offset target) {
    swirling = true;
    swirlTarget = target;
  }

  Color getGoldColor() {
    List<Color> shades = [
      Colors.amber.shade400,
      Colors.amber.shade600,
      Colors.yellow.shade700,
      Colors.amberAccent.shade100,
    ];
    return shades[random.nextInt(shades.length)];
  }
}

// 🔹 Pop particle class
class PopParticle {
  Offset position;
  Offset velocity;
  double size;
  final Color color;

  PopParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });

  void update() {
    position += velocity;
    size *= 0.92;
  }
}

// 🔹 Painter for background + pop particles
class MultiColorFireflyPainter extends CustomPainter {
  final List<GoldFirefly> fireflies;
  final List<PopParticle> popParticles;

  MultiColorFireflyPainter(this.fireflies, this.popParticles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var f in fireflies) {
      paint.color = f.getGoldColor().withOpacity(f.opacity);
      canvas.drawCircle(f.position, f.size, paint);
    }

    for (var p in popParticles) {
      paint.color = p.color;
      canvas.drawCircle(p.position, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 🔹 Next Screen
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0135),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          "Welcome to VEDA 2K25",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          "You are on the Next Screen!",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}