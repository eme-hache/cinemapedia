import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/config/constants/routes.dart';

class MoviesSlideshow extends StatelessWidget {
  const MoviesSlideshow({super.key, required this.movies});

  final List<Movie> movies;

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
  const _Slide({required this.movie});

  final Movie movie;

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
              child: GestureDetector(
                onTap: () => context.push('${Routes.home}/movie/${movie.id}'),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageContainer(
                      height: double.maxFinite,
                      radius: 20,
                      imageUrl: movie.backdropPath,
                    ),
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
                          )),
                    )
                  ],
                ),
              ))),
    );
  }
}
