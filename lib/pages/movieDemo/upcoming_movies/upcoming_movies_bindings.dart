import 'package:get/get.dart';
import 'package:getx_structure/pages/movieDemo/upcoming_movies/upcoming_movies_controller.dart';

  class UpcomingMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpcomingMovieController());
  }
}