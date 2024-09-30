import 'package:flutter/material.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:games_app/providers/games_provider.dart';
import 'package:games_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeProvider>(
            create: (_) => DarkModeProvider()),
        ChangeNotifierProvider<GamesProvider>(create: (_) => GamesProvider()),
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
