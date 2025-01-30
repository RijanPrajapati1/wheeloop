import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSignupDependencies();
  await _initLoginDepedencies();
  await _initSplashScreenDependencies();
  await _initOnBoardingScreenDependencies();
  await _initHomeDependencies();
  await _initDashboardDependencies();
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
  serviceLocator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(serviceLocator<AuthLocalRepository>()),
  );

  serviceLocator.registerFactory<LoginScreenCubit>(
    () => LoginScreenCubit(
        serviceLocator<SignUpScreenCubit>(), serviceLocator<LoginUseCase>()),
  );
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

_initDashboardDependencies() async {
  serviceLocator.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}
