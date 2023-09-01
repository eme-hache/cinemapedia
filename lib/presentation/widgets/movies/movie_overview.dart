import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({
    super.key,
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(imageUrl: movie.posterPath, height: 150, radius: 20),
          const SizedBox(width: 10),
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleLarge),
                Text(movie.overview),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: Row(
                    children: [
                      Icon(Icons.star_half_outlined,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 3),
                      Text(HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium
                              ?.copyWith(color: Colors.yellow.shade800)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text('Estreno:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}