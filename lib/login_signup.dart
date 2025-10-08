import 'package:departmentspg/department_list_screen.dart';
import 'package:departmentspg/home_page.dart';
import 'package:departmentspg/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class LoginSignupPage extends StatefulWidget {
  final bool isLoginStart;

  const LoginSignupPage({super.key, required this.isLoginStart});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLogin = true;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String savedFirstName = '';
  String savedLastName = '';
  String savedEmail = '';
  String savedPassword = '';

  @override
  void initState() {
    super.initState();
    isLogin = widget.isLoginStart;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
           colors: [
              Color.fromARGB(255, 11, 1, 53), 
              Color.fromARGB(255, 12, 2, 62),
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text("#VEDA",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black54,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isLogin ? "Login" : "Signup",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (!isLogin) ...[
                              TextField(
                                controller: _firstNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration("First Name", Icons.person_outline),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _lastNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration("Last Name", Icons.person_outline),
                              ),
                              const SizedBox(height: 15),
                            ],
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputDecoration("Email", Icons.email_outlined),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputDecoration("Password", Icons.lock_outline).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (!isLogin) ...[
                              const SizedBox(height: 20),
                              TextField(
                                controller: _confirmPasswordController,
                                obscureText: !_confirmPasswordVisible,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration("Confirm Password", Icons.lock_outline).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    const Color.fromARGB(255, 60, 54, 54),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: _handleSubmit,
                              child: Text(isLogin ? "Login" : "Signup"),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin
                                    ? "Don't have an account? Signup"
                                    : "Already have an account? Login",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
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

  void _handleSubmit() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (!isLogin &&
        (_firstNameController.text.isEmpty ||
            _lastNameController.text.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            _confirmPasswordController.text.isEmpty)) {
      _showSnackBar("Please fill all the details");
      return;
    }

    if (isLogin && (email.isEmpty || password.isEmpty)) {
      _showSnackBar("Please fill all the details");
      return;
    }
    if (!email.endsWith("@gmail.com")) {
      _showSnackBar("Email must end with @gmail.com");
      return;
    }
    if (password.length < 6 ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      _showSnackBar(
          "Password must be at least 6 chars, include 1 number & 1 special char");
      return;
    }
    if (!isLogin &&
        _passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Password and Confirm Password do not match");
      return;
    }

    if (!isLogin) {
      savedFirstName = _firstNameController.text.trim();
      savedLastName = _lastNameController.text.trim();
      savedEmail = email;
      savedPassword = password;
      _showSnackBar("Signup Successful! Please login.");
      setState(() {
        isLogin = true;
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      });
      return;
    }
    if (email != savedEmail || password != savedPassword) {
      _showSnackBar("Invalid email or password");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>HomePage(),
      ),
    );
  }

  void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black), // Set text color to black
      ),
      backgroundColor: const Color.fromARGB(255, 221, 221, 225),
    ),
  );
}


  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final String name;
  const WelcomePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 11, 1, 53), 
              Color.fromARGB(255, 12, 2, 62), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "#VEDA",
              style: TextStyle(
                fontSize: 40,  
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black54,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Welcome, $name!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
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