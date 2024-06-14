import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:group_project/backend/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:group_project/backend/auth/infraestructure/sources/auth_supabase_api.dart';
import 'package:group_project/backend/core/database/env.dart';
import 'package:group_project/config/routes.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KwunLocalStorage.init();

  if (KwunLocalStorage.getString("favorites").isEmpty) {
    await KwunLocalStorage.setString("favorites", "[]");
  }

  final supabase = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ReserveFormProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(
          create: (context) => UserProvider(AuthRepositoryImpl(
              remoteApi: AuthSupabaseApi(supabase: supabase.client)))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DineIn',
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: router,
    );
  }
}
