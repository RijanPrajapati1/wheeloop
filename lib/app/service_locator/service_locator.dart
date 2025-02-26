import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheeloop/app/shared_prefs/token_shared_prefs.dart';
import 'package:wheeloop/core/network/api_service.dart';
import 'package:wheeloop/core/network/hive_service.dart';
import 'package:wheeloop/features/admin/data/data_source/remote_data_source/car_remote_datasource.dart';
import 'package:wheeloop/features/admin/data/repository/car_remote_repository/car_remote_repository.dart';
import 'package:wheeloop/features/admin/domain/repository/car_repository.dart';
import 'package:wheeloop/features/admin/domain/use_case/car_fetch_usecase.dart';
import 'package:wheeloop/features/admin/domain/use_case/car_usecase.dart';
import 'package:wheeloop/features/admin/domain/use_case/upload_car_image.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_car_cubit.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_fetching_car_cubit.dart';
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
  await _initSharedPreferences();
  await _initSignupDependencies();
  await _initLoginDepedencies();
  await _initSplashScreenDependencies();
  await _initOnBoardingScreenDependencies();

  await _initAdminDependencies();

  await _initHomeDependencies();
  await _initDashboardDependencies();
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

_initAdminDependencies() async {
  // Register Data Source
  serviceLocator.registerLazySingleton<CarRemoteDataSource>(
    () => CarRemoteDataSource(serviceLocator<Dio>()),
  );

  // Register Repository
  serviceLocator.registerLazySingleton<ICarRepository>(
    () => CarRemoteRepository(serviceLocator<CarRemoteDataSource>()),
  );

  // Register Use Cases
  serviceLocator.registerLazySingleton<AddCarUseCase>(
    () => AddCarUseCase(serviceLocator<ICarRepository>()),
  );

  serviceLocator.registerLazySingleton<UploadCarImageUseCase>(
    () => UploadCarImageUseCase(serviceLocator<ICarRepository>()),
  );

  //  Register Fetch Cars Use Case
  serviceLocator.registerLazySingleton<GetAllCarsUseCase>(
    () => GetAllCarsUseCase(serviceLocator<ICarRepository>()),
  );

  // Register AdminCarCubit
  serviceLocator.registerFactory<AdminCarCubit>(
    () => AdminCarCubit(
      serviceLocator<AddCarUseCase>(),
      serviceLocator<UploadCarImageUseCase>(),
    ),
  );

  //  Register AdminFetchCarCubit
  serviceLocator.registerFactory<AdminFetchCarCubit>(
    () => AdminFetchCarCubit(serviceLocator<GetAllCarsUseCase>()),
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
