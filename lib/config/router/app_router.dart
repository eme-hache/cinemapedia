import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: HomeMoviesScreen.name,
      builder: (context, state) => const HomeMoviesScreen(),
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) =>
                MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id')),
      ])
]);
