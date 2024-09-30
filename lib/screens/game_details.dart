import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GamesProvider>(
        builder: (context, gameDetailsProvider, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            gameDetailsProvider.isLoading ||
                    gameDetailsProvider.detailedGameModel == null
                ? "Loading..."
                : gameDetailsProvider.detailedGameModel!.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: gameDetailsProvider.isLoading &&
                  gameDetailsProvider.detailedGameModel == null
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
                                  gameDetailsProvider
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
                                  if (gameDetailsProvider
                                      .detailedGameModel!.platform
                                      .toUpperCase()
                                      .contains("Windows".toUpperCase()))
                                    const Icon(
                                      FontAwesomeIcons.computer,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  const SizedBox(width: 16),
                                  if (gameDetailsProvider
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
                                gameDetailsProvider.detailedGameModel!.gameUrl,
                              );
                            },
                            child: Text("data")),
                        const SizedBox(height: 8),
                        Text(
                          gameDetailsProvider.detailedGameModel!.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          gameDetailsProvider
                              .detailedGameModel!.shortDescription,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: gameDetailsProvider
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
                                            gameDetailsProvider
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
                                          gameDetailsProvider.detailedGameModel!
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
                              gameDetailsProvider
                                  .detailedGameModel!.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                        if (gameDetailsProvider
                                .detailedGameModel!.minimumSystemRequirements !=
                            null)
                          MinimumSystemRequirmentsCard(
                              minimumSystemRequirments:
                                  gameDetailsProvider
                                .detailedGameModel!.minimumSystemRequirements
                                  ),
                        const SizedBox(height: 16),
                        const Text(
                          "Similar Games",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: size.height * 0.33,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: gameDetailsProvider.similarGames.length,
                            itemBuilder: (context, index) => SizedBox(
                              height: 150,
                              width: size.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: GameCard(
                                    gameModel: gameDetailsProvider
                                        .similarGames[index]),
                              ),
                            ),
                          ),
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
