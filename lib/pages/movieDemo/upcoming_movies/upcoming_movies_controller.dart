import 'dart:convert';

import 'package:get/get.dart';
import '../../../api_services/api_service.dart';
import '../../../constants/components.dart';
import '../../../data/upcomingModel.dart';
import '../../../utills/storage_utils.dart';

class UpcomingMovieController extends GetxController {

  final upcomingMovies = <Result>[].obs;
  final filteredMovies = <Result>[].obs;

  String searchQuery = '';
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    filterMovies(searchQuery);
  }

  fetchData() {
    checkConnectivity().then((connectivity) async {
      if (connectivity) {
        final response = await ApiService.getRequest(ApiService.upcomingMovies);
        if (response != null) {
          StorageUtil.setData(StorageUtil.keyToken, jsonEncode(response));
          final model = UpcomingImages.fromJson(response);
          upcomingMovies.value = model.results??[];
          isLoading = false;
          update();
        }
      }else{
        StorageUtil.getData(StorageUtil.keyToken).then((value) {
          if (value != null) {
            final model = UpcomingImages.fromJson(jsonDecode(value));
            if (model != null) {
              upcomingMovies.value = model.results??[];
              isLoading = false;
              update();
            }
          }
        });
      }
      isLoading = false;
      update();
    });
  }

  void filterMovies(String query) {
    searchQuery = query;
    if (query.isNotEmpty) {
      filteredMovies.value = upcomingMovies.where((movie) {
        return movie.originalTitle!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredMovies.value = upcomingMovies;
    }
    update();
  }
}
