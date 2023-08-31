import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[HomeView(), SizedBox(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(widget.pageIndex,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 250));
    }

    return Scaffold(
      body: Center(
        child: PageView(
          // * Avoids lateral scroll
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: viewRoutes,
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavigationbar(currentIndex: widget.pageIndex),
    );
  }
}
