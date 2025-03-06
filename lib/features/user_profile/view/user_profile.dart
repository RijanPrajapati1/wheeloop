import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/user_profile/view_model/user_profile_cubit.dart';
import 'package:wheeloop/features/user_profile/view_model/user_profile_state.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(Dio())..fetchUserProfile(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileLoaded) {
              final userProfile = state.userProfile;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${userProfile['name']}",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text("Email: ${userProfile['email']}",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Phone: ${userProfile['phone']}",
                        style: const TextStyle(fontSize: 16)),
                    // Add more user details as required
                  ],
                ),
              );
            } else if (state is UserProfileError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
