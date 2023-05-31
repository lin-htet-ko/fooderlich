import 'dart:developer';

import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/mag2.png",
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.book,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Recipe Treads",
                    style: FooderlichTheme.darkTextTheme.headline2,
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 0,
                  children: [
                    Chip(
                      label: Text(
                        "Healthy",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: () {
                        log("Delete");
                      },
                    ),
                    Chip(
                      label: Text(
                        "Healthy",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: () {
                        log("Delete");
                      },
                    ),
                    Chip(
                      label: Text(
                        "Vegan",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                    Chip(
                      label: Text(
                        "Greens",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                    Chip(
                      label: Text(
                        "Wheat",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                    Chip(
                      label: Text(
                        "Pescetarian",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                    Chip(
                      label: Text(
                        "Mint",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                    Chip(
                      label: Text(
                        "Lemongrass",
                        style: FooderlichTheme.darkTextTheme.bodyText1,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
