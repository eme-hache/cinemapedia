import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_the_moviedb.dart';

class MovieMapper {
  static Movie theMovieDBToEntity(MovieTheMovieDB theMovieDb) => Movie(
      adult: theMovieDb.adult,
      backdropPath: (theMovieDb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${theMovieDb.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      genreIds: theMovieDb.genreIds.map((e) => e.toString()).toList(),
      id: theMovieDb.id,
      originalLanguage: theMovieDb.originalLanguage,
      originalTitle: theMovieDb.originalTitle,
      overview: theMovieDb.overview,
      popularity: theMovieDb.popularity,
      posterPath: (theMovieDb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${theMovieDb.posterPath}'
          : 'no-poster',
      releaseDate: theMovieDb.releaseDate,
      title: theMovieDb.title,
      video: theMovieDb.video,
      voteAverage: theMovieDb.voteAverage,
      voteCount: theMovieDb.voteCount);
}
