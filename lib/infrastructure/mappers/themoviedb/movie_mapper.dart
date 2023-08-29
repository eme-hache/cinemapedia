import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieMapper {
  static Movie theMovieDBToEntity(MovieGeneral theMovieDb) => Movie(
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
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiUqGvs-Wgpbk4a8HcVMjOVeHJ7kiryV12xpX-WwjUty5NwqHlMTm4M1caosM6IYxkW9I&usqp=CAU',
      releaseDate: theMovieDb.releaseDate != null ? theMovieDb.releaseDate! : DateTime.now(),
      title: theMovieDb.title,
      video: theMovieDb.video,
      voteAverage: theMovieDb.voteAverage,
      voteCount: theMovieDb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
      adult: movie.adult,
      backdropPath: (movie.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      genreIds: movie.genres.map((e) => e.name).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: (movie.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
          : 'no-poster',
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);
}
