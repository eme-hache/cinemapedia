import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDBUrl = dotenv.env['THE_MOVIEDB_URL'] ?? 'NO_URL';
  static String theMovieDBKey = dotenv.env['THE_MOVIEDB_API_KEY'] ?? 'NO_API_KEY';
}
