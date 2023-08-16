import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeMoviesScreen extends StatelessWidget {
  static const String name = 'home-screen';

  const HomeMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeMoviesView(),
      ),
    );
  }
}

class _HomeMoviesView extends ConsumerStatefulWidget {
  const _HomeMoviesView();

  @override
  _HomeMoviesViewState createState() => _HomeMoviesViewState();
}

class _HomeMoviesViewState extends ConsumerState<_HomeMoviesView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // if (nowPlayingMovies.isEmpty) return const CircularProgressIndicator();

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: nowPlayingMovies)

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context, index) {
        //       final movie = nowPlayingMovies[index];
        
        //       return ListTile(
        //         title: Text(movie.title),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
