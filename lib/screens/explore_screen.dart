import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late ScrollController scrollController;
  final mockService = MockFooderlichService();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener(){
      if (scrollController.offset ==
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        log("I am on top");
      }
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        log("I am on bottom");
      }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockService.getExploreData(),
        builder: (con, AsyncSnapshot<ExploreData> snapshot) {
          var exploreData = snapshot.data;

          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
                child: ListView(
              controller: scrollController,
              children: [
                ExploreRecipeListView(recipes: exploreData?.todayRecipes ?? []),
                const SizedBox(
                  height: 16,
                ),
                FriendPostListView(posts: exploreData?.friendPosts ?? [])
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    scrollController.removeListener(_scrollListener);
  }
}
