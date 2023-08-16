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
      bottomNavigationBar: CustomBottomNavigationbar(),
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
    final nowPlayingMoviesSlideshow = ref.watch(moviesSlideShowProvider);

    // if (nowPlayingMovies.isEmpty) return const CircularProgressIndicator();

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          centerTitle: true,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: nowPlayingMoviesSlideshow),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subtitle: 'Lunes 20',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Proximamente',
              subtitle: 'En este mes',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Populares',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Mejor calificadas',
              subtitle: 'Desde siempre',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
