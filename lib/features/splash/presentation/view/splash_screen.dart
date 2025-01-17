import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Initialize the animation
    _animation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation and navigate after the animation completes
    _controller.forward();

    // Initialize SplashScreenCubit
    context.read<SplashScreenCubit>().init(context);
  }

  @override
  void dispose() {
    // Dispose the animation controller when done
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashScreenCubit, SplashScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Background with gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4A148C), // Deep Purple shade
                      Color(0xFF6A1B9A), // Lighter Purple shade
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Content
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Title
                    const Text(
                      'WHEELOOP',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Subtitle
                    Text(
                      'Rent a luxury car for your travel\nwhenever you want with your device!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[300],
                      ),
                    ),
                    const Spacer(),
                    // Car Image Placeholder with animation
                    SlideTransition(
                      position: _animation,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.9, // 90% width
                        height: MediaQuery.of(context).size.height *
                            0.3, // 30% height
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/carr.png'), // Add your car image
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Loading indicator (only when loading)
                    if (state is SplashScreenLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 252, 252, 252)),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
