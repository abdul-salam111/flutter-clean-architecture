import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/app_secrets/app_secrets.dart';
import 'package:flutter_clean_architecture/core/theme/theme.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:flutter_clean_architecture/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignup: UserSignUp(
              AuthRepositoryImpl(AuthRemoteDatasourceImp(supabase.client)),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App With clean architecture',
      theme: AppTheme.darkThemeMode,
      home: LoginPage(),
    );
  }
}
