import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:games_app/helpers/clickable/drawer_tile.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:games_app/providers/games_provider.dart';
import 'package:games_app/widgets/cards/game_card.dart';
import 'package:flutter/material.dart';
import 'package:games_app/widgets/cards/minimum_system_requirments_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({super.key, required this.gameId});
  final String gameId;

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  bool isShowMore = false;

  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false)
        .fetchGameById(widget.gameId);
    Provider.of<DarkModeProvider>(context, listen: false).getMode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<GamesProvider, DarkModeProvider>(
        builder: (context, gameDetailsConsumer, darkModeConsumer, child) {
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
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            gameDetailsConsumer.isLoading ||
                    gameDetailsConsumer.detailedGameModel == null
                ? "Loading..."
                : gameDetailsConsumer.detailedGameModel!.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: gameDetailsConsumer.isLoading &&
                  gameDetailsConsumer.detailedGameModel == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            FullScreenWidget(
                              disposeLevel: DisposeLevel.Medium,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  gameDetailsConsumer
                                      .detailedGameModel!.thumbnail,
                                  width: size.width,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Row(
                                children: [
                                  if (gameDetailsConsumer
                                      .detailedGameModel!.platform
                                      .toUpperCase()
                                      .contains("Windows".toUpperCase()))
                                    const Icon(
                                      FontAwesomeIcons.computer,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  const SizedBox(width: 16),
                                  if (gameDetailsConsumer
                                      .detailedGameModel!.platform
                                      .toUpperCase()
                                      .contains("web".toUpperCase()))
                                    const Icon(
                                      FontAwesomeIcons.globe,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              LaunchExternalUrl(
                                gameDetailsConsumer.detailedGameModel!.gameUrl,
                              );
                            },
                            child: const Text("data")),
                        const SizedBox(height: 8),
                        Text(
                          gameDetailsConsumer.detailedGameModel!.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkModeConsumer.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          gameDetailsConsumer
                              .detailedGameModel!.shortDescription,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: darkModeConsumer.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: gameDetailsConsumer
                                .detailedGameModel!.screenshots.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FullScreenWidget(
                                disposeLevel: DisposeLevel.Medium,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Hero(
                                          tag: 'hero',
                                          child: Image.network(
                                            gameDetailsConsumer
                                                .detailedGameModel!
                                                .screenshots[index]
                                                .image,
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: "hero",
                                        child: Image.network(
                                          gameDetailsConsumer.detailedGameModel!
                                              .screenshots[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gameDetailsConsumer
                                  .detailedGameModel!.description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: darkModeConsumer.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              maxLines: isShowMore ? 50 : 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowMore = !isShowMore;
                                });
                              },
                              child: Text(
                                isShowMore ? "show less..." : "show more...",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (gameDetailsConsumer
                                .detailedGameModel!.minimumSystemRequirements !=
                            null)
                          MinimumSystemRequirmentsCard(
                              minimumSystemRequirments: gameDetailsConsumer
                                  .detailedGameModel!
                                  .minimumSystemRequirements),
                        const SizedBox(height: 16),
                        Text(
                          "Similar Games",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: darkModeConsumer.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: size.height * 0.33,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  gameDetailsConsumer.similarGames.length,
                              itemBuilder: (context, index) {
                                print(gameDetailsConsumer.games[index].title);
                                return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: gameDetailsConsumer.isLoading
                                            ? const CircularProgressIndicator()
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GameDetailsScreen(
                                                                  gameId: gameDetailsConsumer
                                                                      .similarGames[
                                                                          index]
                                                                      .id
                                                                      .toString())));
                                                },
                                                child: SizedBox(
                                                  width: 300,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: GameCard(
                                                        gameModel:
                                                            gameDetailsConsumer
                                                                    .similarGames[
                                                                index]),
                                                  ),
                                                ),
                                              )));
                              }),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

LaunchExternalUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
