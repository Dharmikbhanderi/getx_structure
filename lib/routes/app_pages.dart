
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/movieDemo/movies_details/movies_details_bindings.dart';
import '../pages/movieDemo/movies_details/movies_details_view.dart';
import '../pages/movieDemo/upcoming_movies/upcoming_movies_bindings.dart';
import '../pages/movieDemo/upcoming_movies/upcoming_movies_view.dart';
import '../pages/splash/splash_bindings.dart';
import '../pages/splash/splash_view.dart';

part 'app_routes.dart';


class AppPages {
  static const initialRoute = Routes.splash;

  static final routes = [
    GetPage(name: _Paths.splash,
        page: () =>   SplashView(),
        binding: SplashBindings()),
    GetPage(
      name: _Paths.home,
      page: () =>   UpcomingMoviePage(),
      binding: UpcomingMovieBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.movieDetail,
      page: () => MovieDetailsPage(),
      binding: MovieDetailsBinding(),
    ),
  ];
}