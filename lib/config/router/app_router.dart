import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:view',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex =
            int.parse((state.pathParameters['view'] ?? 0).toString());

        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) =>
                MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id')),
      ]),
  GoRoute(path: '/', redirect: (_, __) => '/home/0')
]);
