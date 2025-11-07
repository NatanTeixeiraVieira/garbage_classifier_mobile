import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/pages/register_screen.dart';
import 'features/auth/presentation/cubits/register_cubit.dart';
import 'features/camera/presentation/cubits/camera_cubit.dart';
import 'features/auth/presentation/cubits/app_cubit.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'injection.dart';
import 'features/auth/domain/usecases/get_session_userid_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  final getSession = getIt<GetSessionUserIdUseCase>();
  final appCubit = getIt<AppCubit>();
  final storedId = await getSession();
  if (storedId != null) {
    appCubit.setCurrentUserId(storedId);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const sky500 = Color(0xFF4ADE80);

    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: sky500,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 67, 214, 121), width: 2),
        ),
        labelStyle: TextStyle(color: Color.fromARGB(221, 7, 7, 7)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: sky500,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme:
          ColorScheme.fromSeed(seedColor: sky500, brightness: Brightness.dark),
      useMaterial3: true,
    );

    final appCubit = getIt<AppCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<CameraCubit>()),
        BlocProvider(create: (context) => appCubit),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        bloc: appCubit,
        builder: (context, state) {
          final home = state.currentUserId != null
              ? const HomeScreen()
              : const RegisterScreen();
          return MaterialApp(
            title: "Garbage Classifier",
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: home,
          );
        },
      ),
    );
  }
}
