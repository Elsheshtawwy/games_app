import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_app/helpers/clickable/drawer_tile.dart';
import 'package:games_app/helpers/clickable/mainButton.dart';
import 'package:games_app/helpers/consts.dart';
import 'package:games_app/main.dart';
import 'package:games_app/providers/auth_provider.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:games_app/providers/games_provider.dart';
import 'package:games_app/screens/favorite_games_screen.dart';
import 'package:games_app/widgets/cards/game_card.dart';
import 'package:games_app/widgets/dialogs/add_to_favorite_dialog.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GamesProvider, DarkModeProvider>(
        builder: (context, gamesConsumer, darkModeConsumer, child) {
      return Scaffold(
        drawer: Drawer(
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
                MainButton(
                    label: "Logout",
                    onPressed: () {
                      Provider.of<Auth_Provider>(context, listen: false)
                          .logout()
                          .then((logedOut) {
                        if (logedOut) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const ScreenRouter()),
                              (route) => false);
                        }
                      });
                    })
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("GAMER"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const FavoriteGamesScreen()));
                },
                icon: const Icon(Icons.favorite))
          ],
        ),
        body: Center(
            child: GridView.builder(
                itemCount: gamesConsumer.busy ? 6 : gamesConsumer.games.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: gamesConsumer.busy
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.white38,
                                  child: Container(
                                    color: Colors.white,
                                    height: double.infinity,
                                    width: double.infinity,
                                  )),
                            )
                          : GameCard(
                              gameModel: gamesConsumer.games[index],
                              onLongPress: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AddToFavoriteDialog(
                                        gameModel: gamesConsumer.games[index],
                                      );
                                    });
                              },
                            ));
                })),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: redColor,
            selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.normal, fontSize: 12),
            onTap: (currentIndex) {
              setState(() {
                nowIndex = currentIndex;
              });

              Provider.of<GamesProvider>(context, listen: false)
                  .fetchGames(currentIndex == 0
                      ? "all"
                      : currentIndex == 1
                          ? "pc"
                          : "browser");
            },
            currentIndex: nowIndex,
            items: const [
              BottomNavigationBarItem(
                  label: "All", icon: Icon(FontAwesomeIcons.gamepad)),
              BottomNavigationBarItem(
                  label: "PC", icon: Icon(FontAwesomeIcons.computer)),
              BottomNavigationBarItem(
                  label: "WEB", icon: Icon(FontAwesomeIcons.globe)),
            ]),
      );
    });
  }
}
