import 'package:flutter/material.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.text,
      required this.icon,
      this.withDivider = true});
  final String text;
  final IconData icon;
  final bool withDivider;
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: darkModeConsumer.isDark
                    ? Colors.black
                    : Colors.white.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon,
                      color: darkModeConsumer.isDark
                          ? Colors.white
                          : Colors.black),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: darkModeConsumer.isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                  Switch(
                      value: darkModeConsumer.isDark,
                      onChanged: (value) {
                        darkModeConsumer.SwitchMode();
                      },
                      activeColor: darkModeConsumer.isDark
                              ? Colors.white
                              : Colors.black,
                      )
                ],
              ),
            ),
          ),
          if (withDivider)
            const Divider(
              thickness: 1,
              endIndent: 5,
              indent: 5,
            ),
        ],
      );
    });
  }
}
