import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';

class OnboardingScreen extends StatelessWidget {
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

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingScreenCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingScreenCubit, int>(
          builder: (context, currentPage) {
            final cubit = context.read<OnboardingScreenCubit>();

            return Container(
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
                    controller: cubit.pageController,
                    onPageChanged: (index) {
                      context
                          .read<OnboardingScreenCubit>()
                          .updatePage(index); // Call the method
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
                      visible: currentPage > 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => cubit.previousPage(),
                      ),
                    ),
                  ),
                  // Dots Indicator
                  Positioned(
                    bottom: 120,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 12,
                          width: currentPage == index ? 24 : 12,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
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
                        if (currentPage == _pages.length - 1) {
                          context
                              .read<OnboardingScreenCubit>()
                              .navigateToLogin(context);
                        } else {
                          cubit.nextPage();
                        }
                      },
                      child: Text(
                        currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          page.imagePath,
          width: screenWidth * 0.9,
          height: screenWidth * 0.6,
          fit: BoxFit.contain,
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
