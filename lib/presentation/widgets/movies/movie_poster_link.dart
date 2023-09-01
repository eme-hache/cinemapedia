import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/config/constants/routes.dart';

class MoviePosterLink extends StatelessWidget {
  const MoviePosterLink({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: GestureDetector(
          onTap: () => context.push('${Routes.home}/movie/${movie.id}'),
          child: ImageContainer(
            height: 180,
            radius: 10,
            imageUrl: movie.posterPath,
          )),
    );
  }
}
