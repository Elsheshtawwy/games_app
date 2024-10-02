import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_app/helpers/clickable/drawer_tile.dart';
import 'package:games_app/helpers/clickable/mainButton.dart';
import 'package:games_app/main.dart';
import 'package:games_app/providers/auth_provider.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:games_app/providers/games_provider.dart';
import 'package:games_app/screens/game_details.dart';
import 'package:games_app/widgets/cards/game_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nowIndex = 0;

  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false).fetchGames("all");
    Provider.of<DarkModeProvider>(context, listen: false).getMode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GamesProvider, DarkModeProvider>(
        builder: (context, gamesProvider, darkModeConsumer, child) {
      return Scaffold(
        drawer: Drawer(
          backgroundColor:
              darkModeConsumer.isDark ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                DrawerTile(
                  icon: darkModeConsumer.isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  text: darkModeConsumer.isDark ? "Dark Mode" : "Light Mode",
                ),
                Mainbutton(
                  onPressed: () {
                    Provider.of<Auth_Provider>(context, listen: false)
                        .logout()
                        .then((loggedOut) {
                      if (loggedOut) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ScreenRouter(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logout failed'),
                          ),
                        );
                      }
                    });
                  },
                  label: "Log Out",
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(),
        body: Center(
          child: GridView.builder(
            itemCount: gamesProvider.busy ? 6 : gamesProvider.games.length,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: gamesProvider.busy
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white38,
                          child: Container(
                            color: Colors.white,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameDetailsScreen(
                                      gameId: gamesProvider.games[index].id
                                          .toString())));
                        },
                        child: GameCard(
                          gameModel: gamesProvider.games[index],
                        ),
                      ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              darkModeConsumer.isDark ? Colors.black : Colors.white,
          selectedLabelStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: darkModeConsumer.isDark ? Colors.white : Colors.black,
          ),
          unselectedLabelStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: darkModeConsumer.isDark ? Colors.white : Colors.black,
          ),
          onTap: (currentIndex) {
            setState(() {
              nowIndex = currentIndex;
            });

            gamesProvider.fetchGames(currentIndex == 0
                ? "all"
                : currentIndex == 1
                    ? "pc"
                    : "browser");
          },
          currentIndex: nowIndex,
          items: [
            BottomNavigationBarItem(
                label: "ALL",
                icon: Icon(
                  FontAwesomeIcons.gamepad,
                  color: darkModeConsumer.isDark ? Colors.white : Colors.black,
                )),
            BottomNavigationBarItem(
                label: "PC",
                icon: Icon(
                  FontAwesomeIcons.computer,
                  color: darkModeConsumer.isDark ? Colors.white : Colors.black,
                )),
            BottomNavigationBarItem(
                label: "WEB",
                icon: Icon(
                  FontAwesomeIcons.globe,
                  color: darkModeConsumer.isDark ? Colors.white : Colors.black,
                )),
          ],
        ),
      );
    });
  }
}
