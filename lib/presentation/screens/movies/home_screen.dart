import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

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
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    //if (initialLoading) return const FullScreenLoader();

    final nowPlayingMoviesSlideshow = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upconmingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Stack(
      children: [
        if (initialLoading) const FullScreenLoader(),
        Visibility(
          visible: !initialLoading,
          child: CustomScrollView(slivers: [
            const SliverAppBar(
              floating: true,
              toolbarHeight: 70,
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
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: upconmingMovies,
                    title: 'Proximamente',
                    subtitle: 'En este mes',
                    loadNextPage: () => ref
                        .read(upcomingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'Desde siempre',
                    loadNextPage: () => ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              );
            }, childCount: 1))
          ]),
        ),
      ],
    );
  }
}
