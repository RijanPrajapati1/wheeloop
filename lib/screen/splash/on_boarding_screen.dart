import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imagePath: 'assets/images/on_board_1.png',
      title: 'Explore Luxury Cars',
      description:
          'Browse through a variety of luxury cars and find the perfect match for your travel needs.',
    ),
    OnboardingPage(
      imagePath: 'assets/images/on_board_2.png',
      title: 'Easy Booking Process',
      description:
          'Book your dream car seamlessly with just a few taps on your device.',
    ),
    OnboardingPage(
      imagePath: 'assets/images/on_board_3.png',
      title: 'Flexible Rentals',
      description:
          'Rent cars on your terms – hourly, daily, or weekly plans to suit your journey.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A148C), // Deep Purple
              Color(0xFF6A1B9A), // Lighter Purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // PageView for onboarding pages
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return OnboardingContent(page: _pages[index]);
              },
            ),
            // Back Button
            Positioned(
              top: 50,
              left: 20,
              child: Visibility(
                visible: _currentPage >
                    0, // Show back button only if not on the first page
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pop(
                          context); // Exit onboarding if on the first page
                    }
                  },
                ),
              ),
            ),
            // Dots Indicator (slightly above button)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => buildDot(index),
                ),
              ),
            ),
            // Next / Get Started Button
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  if (_currentPage == _pages.length - 1) {
                    // Navigate to Login or Home screen
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A148C), // Deep purple text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build dots for the page indicator
  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 12,
      width: _currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

// Content for each onboarding page
class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image adjusted based on screen width
        Image.asset(
          page.imagePath,
          width: screenWidth * 0.9, // Image width will be 80% of screen width
          height: screenWidth * 0.6, // Image height will be 60% of screen width
          fit: BoxFit.contain, // Keeps the aspect ratio intact
        ),
        const SizedBox(height: 40),
        Text(
          page.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

// Model for onboarding page
class OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
