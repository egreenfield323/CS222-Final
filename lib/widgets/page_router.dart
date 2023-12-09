import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_data/widgets/cow_widget.dart';

class PageRouter extends StatefulWidget {
  final Widget homePage, favoritesPage, upcomingPage, searchPage;

  const PageRouter({
    Key? key,
    required this.homePage,
    required this.favoritesPage,
    required this.upcomingPage,
    required this.searchPage,
  }) : super(key: key);

  @override
  State<PageRouter> createState() => PageRouterState();
}

class PageRouterState extends State<PageRouter> {
  bool ignoring = false;
  bool hasWaited = false;
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = widget.homePage;
        break;
      case 1:
        page = widget.upcomingPage;
        if (!hasWaited) {
          hasWaited = true;
          ignoring = true;
          Timer(const Duration(seconds: 6), () {
            _setIgnoringState();
          });
        }
        break;
      case 2:
        page = widget.searchPage;
        break;
      case 3:
        page = widget.favoritesPage;
        break;
      case 4:
        page = const CowWidget();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: IgnorePointer(
                  ignoring: ignoring,
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.watch_later_outlined),
                        label: Text('Upcoming'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.thumb_up),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Text(" "),
                        label: Text(" "),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
              ),
              const VerticalDivider(
                thickness: 1,
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                child: Container(
                  color: Colors.white60,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _setIgnoringState() {
    setState(() {
      ignoring = false;
    });
  }

  void changePageIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
  }
}
