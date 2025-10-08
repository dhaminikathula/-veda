import 'package:departmentspg/events_details.dart';
import 'package:departmentspg/events_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'registration_page.dart';
import 'profile_page.dart';
import 'events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 🌟 Bottom Navigation
  int _selectedIndex = 0;

  // Slider controllers
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();
  int _currentIndex = 0;
  int _currentIndex2 = 0;

  late Timer _timer;
  late Timer _timer2;
  bool _isHovered = false;

  final List<String> imagePath = [
    'assets/zero.webp',
    'assets/first.webp',
    'assets/second.jpg',
    'assets/third.webp',
    'assets/two.jpg',
    'assets/six.webp',
  ];

  final List<String> vedaimagePath = [
    'assets/one.webp',
    'assets/twoo.jpg',
    'assets/three.jpg',
    'assets/one.webp',
    'assets/twoo.jpg',
    'assets/three.jpg',
    'assets/one.webp',
    'assets/twoo.jpg',
    'assets/three.jpg',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialize tab pages
    _pages = [
      _buildHomeContent(),
      const DepartmentListScreen(),
      const EventsScreen(),
      const Profile_Page(),
    ];

    // ✅ Main slider timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < imagePath.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });

    // ✅ Second slider timer
    _timer2 = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex2 < vedaimagePath.length - 1) {
        _currentIndex2++;
      } else {
        _currentIndex2 = 0;
      }
      _pageController2.animateToPage(
        _currentIndex2,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    _pageController.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 🏠 Original Home Content
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      key: const ValueKey('home_content'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: SizedBox(
              width: 200,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 120),
                    cursor: '|',
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 🖼 Top Image Slider with Hover
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 244, 246, 249)
                        .withOpacity(0.6),
                    blurRadius: _isHovered ? 30 : 15,
                    spreadRadius: _isHovered ? 6 : 3,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              transform: _isHovered
                  ? Matrix4.translationValues(0, -10, 0)
                  : Matrix4.identity(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagePath.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imagePath[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "The journey of veda",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),

          _buildInfoBox(
              "Veda 2k25 is a National Technology festival and aims to bring together the brightest minds in technology and innovation.",
              left: 20),
          _buildInfoBox(
              "Veda 2k25 brings together a diverse range of department-specific events, each designed to challenge, inspire and foster innovation among the students",
              left: 70),
          _buildInfoBox(
              "Participants can choose from a wide variety of events based on their interests and expertise and showcasing their skills",
              left: 20),
          _buildInfoBox(
              "To participate in any of the events at Veda Fest, you'll need to complete the online registration form, The form is simple and user friendly",
              left: 70),
          _buildInfoBox(
              "Once you have selected your events, the final step is to complete the payment through our secure online gateway. The fee covers participation in multiple events",
              left: 20),
          _buildInfoBox(
              "Our payment gateway is designed to provide a safe and seamless transaction experience. All transactions are protected with SSL encryption",
              left: 70),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "#VEDA Presents",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(height: 20),

          // 🖼 Second Slider
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.6),
                    blurRadius: _isHovered ? 30 : 15,
                    spreadRadius: _isHovered ? 6 : 3,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              transform: _isHovered
                  ? Matrix4.translationValues(0, -10, 0)
                  : Matrix4.identity(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: _pageController2,
                  itemCount: vedaimagePath.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      vedaimagePath[index],
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text, {double left = 20}) {
    return Padding(
      padding: EdgeInsets.only(left: left, bottom: 10),
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 1, 47),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Welcome to #VEDA",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {},
          )
        ],
      ),

      // ✨ Page Animation when switching tabs
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: _pages[_selectedIndex],
      ),

      // 🌟 Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade900.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onNavTapped,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_outlined),
                activeIcon: Icon(Icons.event),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration_outlined),
                activeIcon: Icon(Icons.app_registration),
                label: 'Register',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}