import 'package:get/get.dart';
import '../../../api_services/api_service.dart';
import '../../../constants/components.dart';
import '../../../data/moviesDetailModel.dart';

class MovieDetailsController extends GetxController {
  int movieId = Get.arguments[0];

  bool isLoading = true;
  List<MovieDetailsModel> movieData = [];

  @override
  void onInit() {
    postData();

    super.onInit();
  }

  postData() {
    checkConnectivity().then((connectivity){
      if (connectivity) {
       ApiService.getRequest(
            '/movie/$movieId?api_key=$apiKey').then((response) {
         if (response != null) {
           movieData.add(MovieDetailsModel.fromMap(response));
           showSnackBar('${movieData[0].originalTitle}');
           isLoading = false;
           update();
         } else {
           showSnackBar('responseModel.message');
         }
       });
      }
    });
  }
}