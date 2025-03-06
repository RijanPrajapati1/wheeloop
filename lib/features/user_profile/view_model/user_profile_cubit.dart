import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';
import 'package:wheeloop/features/user_profile/view_model/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final Dio dio;

  UserProfileCubit(this.dio) : super(UserProfileInitial());

  Future<void> fetchUserProfile(String userId) async {
    try {
      emit(UserProfileLoading());
      final response =
          await dio.get("${ApiEndpoints.baseUrl}user/profile/$userId");

      if (response.statusCode == 200) {
        final userProfile = response
            .data['userId']; // Assuming profile data is under 'profile' key
        emit(UserProfileLoaded(userProfile: userProfile));
      } else {
        emit(const UserProfileError(message: "Failed to load user profile"));
      }
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }
}
