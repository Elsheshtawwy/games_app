import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:games_app/providers/auth_provider.dart';
import 'package:games_app/providers/base_provider.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:games_app/providers/games_provider.dart';
import 'package:games_app/screens/home_screen.dart';
import 'package:games_app/screens/loginscreen.dart';
import 'package:games_app/screens/register.dart';
import 'package:games_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<BaseProvider>(
            create: (_) => BaseProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (_) => DarkModeProvider()),
        ChangeNotifierProvider<GamesProvider>(create: (_) => GamesProvider()),
        ChangeNotifierProvider<Auth_Provider>(create: (_)=> Auth_Provider())
      ],
      child:
          Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor:
                darkModeConsumer.isDark ? Colors.black : Colors.white,
            dividerTheme: DividerThemeData(
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {
    return firebaseAuth.currentUser != null
        ? const HomeScreen()
        : const RegisterScreen();
  }
}
