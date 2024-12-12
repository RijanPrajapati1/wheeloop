import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 3),
              const Text(
                "Create an Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.deepPurple,
                    letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Fill in the details to create an account",
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/logos/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                    child: Icon(
                      _obscureTextPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: _obscureTextConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureTextConfirmPassword =
                            !_obscureTextConfirmPassword;
                      });
                    },
                    child: Icon(
                      _obscureTextConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Add signup logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black, letterSpacing: 1),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login screen
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue, letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
