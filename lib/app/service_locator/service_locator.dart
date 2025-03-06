import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheeloop/app/shared_prefs/token_shared_prefs.dart';
import 'package:wheeloop/core/network/api_service.dart';
import 'package:wheeloop/core/network/hive_service.dart';
import 'package:wheeloop/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:wheeloop/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:wheeloop/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:wheeloop/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:wheeloop/features/auth/domain/use_case/login_usecase.dart';
import 'package:wheeloop/features/auth/domain/use_case/register_usecase.dart';
import 'package:wheeloop/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/booked_car/presentation/view_model/booked_car_cubit.dart';
import 'package:wheeloop/features/booking/data/repository/booking_repo.dart';
import 'package:wheeloop/features/booking/domain/use_case/booking_usecae.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_screen_cubit.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';
import 'package:wheeloop/features/user_profile/view_model/user_profile_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initSignupDependencies();
  await _initLoginDepedencies();
  await _initSplashScreenDependencies();
  await _initOnBoardingScreenDependencies();
  await _initHomeDependencies();
  await _initBookingCarDependencies();
  await _initNotificationDependencies();
  await _initUserProfileDependencies();
  await _initDashboardDependencies();
  await _initBookingDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  // Remote Data Source
  serviceLocator.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

_initSignupDependencies() {
  //init local data source
  serviceLocator.registerLazySingleton(
    () => AuthLocalDataSource(serviceLocator<HiveService>()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthRemoteDataSource(serviceLocator<Dio>()),
  );

  //init local repository
  serviceLocator.registerLazySingleton(
    () => AuthLocalRepository(serviceLocator<AuthLocalDataSource>()),
  );
  serviceLocator.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(serviceLocator<AuthRemoteDataSource>()),
  );

  // register use usecase
  // serviceLocator.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     serviceLocator<AuthLocalRepository>(),
  //   ),
  // );

  serviceLocator.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      serviceLocator<AuthRemoteRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      serviceLocator<AuthRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory<SignUpScreenCubit>(
    () => SignUpScreenCubit(
      registerUseCase: serviceLocator(),
      uploadImageUsecase: serviceLocator(),
    ),
  );
}

_initLoginDepedencies() {
  // register login use case

  //token shared preferenes
  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(serviceLocator<SharedPreferences>()),
  );

  //usecase
  serviceLocator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      serviceLocator<AuthRemoteRepository>(),
      serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory<LoginScreenCubit>(
    () => LoginScreenCubit(
        serviceLocator<SignUpScreenCubit>(), serviceLocator<LoginUseCase>()),
  );

  // serviceLocator.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(serviceLocator<AuthRemoteRepository>()),
  // );

  // serviceLocator.registerFactory<LoginScreenCubit>(
  //   () => LoginScreenCubit(
  //       serviceLocator<SignUpScreenCubit>(), serviceLocator<LoginUseCase>()),
  // );
}

_initSplashScreenDependencies() async {
  serviceLocator.registerFactory<SplashScreenCubit>(
    () => SplashScreenCubit(serviceLocator<OnboardingScreenCubit>()),
  );
}

_initOnBoardingScreenDependencies() async {
  serviceLocator.registerFactory<OnboardingScreenCubit>(
    () => OnboardingScreenCubit(),
  );
}

_initHomeDependencies() async {
  serviceLocator.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initNotificationDependencies() async {
  serviceLocator.registerFactory<NotificationCubit>(
    () => NotificationCubit(serviceLocator<Dio>()), // Pass Dio instance here
  );
}

_initBookingCarDependencies() async {
  serviceLocator.registerFactory<BookedCarCubit>(
    () => BookedCarCubit(serviceLocator<Dio>()), // Pass Dio instance here
  );
}

_initUserProfileDependencies() async {
  serviceLocator.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(serviceLocator<Dio>()), // Pass Dio instance here
  );
}

_initDashboardDependencies() async {
  serviceLocator.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

_initBookingDependencies() async {
  // Register Booking Repository
  serviceLocator.registerLazySingleton<BookingRepository>(
    () => BookingRepository(),
  );

  // Register HandleBookingUseCase
  serviceLocator.registerLazySingleton<HandleBookingUseCase>(
    () => HandleBookingUseCase(serviceLocator<BookingRepository>()),
  );

  // Register Booking Cubit with the correct use case
  serviceLocator.registerFactory<BookingCubit>(
    () => BookingCubit(serviceLocator<HandleBookingUseCase>()),
  );
}
