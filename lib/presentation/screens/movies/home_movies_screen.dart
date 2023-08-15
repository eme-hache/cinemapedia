import 'package:flutter/material.dart';

import 'package:cinemapedia/config/constants/environment.dart';

class HomeMoviesScreen extends StatelessWidget {
  static const String name = 'home-screen';

  const HomeMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.theMovieDBKey),
      ),
    );
  }
}
