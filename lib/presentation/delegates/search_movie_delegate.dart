import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  List<Movie> initialMovies;
  Timer? _debounceTimer;

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  TextStyle get searchFieldStyle => const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  void _clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;

      isLoadingStream.add(false);
      debouncedMovies.add(movies);
    });
  }

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
        initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                _clearStreams();
                close(context, movie);
              },
            ),
          );
        });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.refresh_rounded)));
            }
      
            return FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                    onPressed: () => query = '', icon: const Icon(Icons.clear)));
          },
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          _clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child),
                  )),
            ),
            const SizedBox(width: 10),
            SizedBox(
                width: size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleMedium),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.yellow.shade800),
                        const SizedBox(width: 5),
                        Text(HumanFormats.number(movie.voteAverage, 1),
                            style: textStyles.bodyMedium!
                                .copyWith(color: Colors.yellow.shade900))
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
