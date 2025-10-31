import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/local_database_datasource.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/data/services/password_hash_service.dart';
import 'features/auth/data/services/sha256_password_service.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_user_usecase.dart';
import 'features/auth/domain/usecases/register_user_usecase.dart';
import 'features/auth/presentation/cubits/register_cubit.dart';
import 'features/camera/data/repositories/garbage_classification_repository.dart';
import 'features/camera/domain/repositories/garbage_classification_repository.dart';
import 'features/camera/domain/usecases/classify_garbage_usecase.dart';
import 'features/camera/presentation/cubits/camera_cubit.dart';
import 'features/auth/presentation/cubits/login_cubit.dart'; // <-- import adicionado

final getIt = GetIt.instance;

void setupDependencies() {
  // Auth Feature
  getIt.registerLazySingleton<IPasswordHashService>(
    () => Sha256PasswordService(),
  );

  getIt.registerLazySingleton<ILocalDatabaseDataSource>(
    () => LocalDatabaseDataSource.instance,
  );

  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      getIt<ILocalDatabaseDataSource>(),
      getIt<IPasswordHashService>(),
    ),
  );

  getIt.registerLazySingleton(
    () => RegisterUserUseCase(getIt<IAuthRepository>()),
  );

  getIt.registerLazySingleton(
    () => LoginUserUseCase(getIt<IAuthRepository>()),
  );

  getIt.registerFactory(
    () => RegisterCubit(getIt<RegisterUserUseCase>()),
  );

  getIt.registerFactory(
    () => LoginCubit(getIt<LoginUserUseCase>()),
  );

  // Camera Feature
  getIt.registerLazySingleton<IGarbageClassificationRepository>(
    () => GarbageClassificationRepository(
      baseUrl: 'https://aa7a9974d1cf.ngrok-free.app',
    ),
  );

  getIt.registerLazySingleton(
    () => ClassifyGarbageUseCase(
      getIt<IGarbageClassificationRepository>(),
    ),
  );

  getIt.registerFactory(
    () => CameraCubit(getIt<ClassifyGarbageUseCase>()),
  );
}
