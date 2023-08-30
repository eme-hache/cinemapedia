import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
        height: 250,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.85,
          // autoplay: true,
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(movie: movies[index]),
          pagination: SwiperPagination(
              margin: const EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary,
                color: colors.secondary,
              )),
        ));
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }

                return GestureDetector(
                    onTap: () => context.push('/home/0/movie/${movie.id}'),
                    child: FadeIn(
                        child: Stack(
                      fit: StackFit.expand,
                      children: [
                        child,
                        const DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                              0.7,
                              1.0
                            ],
                                    colors: [
                              Colors.transparent,
                              Colors.black87
                            ]))),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyles.titleMedium
                                          ?.copyWith(color: Colors.white)),
                                ),
                                /* const Spacer(), */
                                const SizedBox(width: 10),
                                Icon(Icons.star, color: Colors.yellow.shade800),
                                const SizedBox(width: 3),
                                Text('${movie.voteAverage}',
                                    style: textStyles.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ],
                            ) /* Text(movie.title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)) */
                            ,
                          ),
                        )
                      ],
                    )));
              },
            ),
          )),
    );
  }
}
