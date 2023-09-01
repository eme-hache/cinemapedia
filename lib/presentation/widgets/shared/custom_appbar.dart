import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/delegates.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/config/constants/routes.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
              size: 35,
            ),
            const SizedBox(width: 10),
            Text('Cinemapedia', style: titleStyle),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showSearch<Movie?>(
                          query: ref.read(searchQueryProvider),
                          context: context,
                          delegate: SearchMovieDelegate(
                              initialMovies: ref.read(searchedMoviesProvider),
                              searchMovies: ref
                                  .read(searchedMoviesProvider.notifier)
                                  .searchMoviesByQuery))
                      .then((movie) {
                    if (movie == null) return;

                    context.push('${Routes.home}/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
