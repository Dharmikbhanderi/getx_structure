import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_structure/constants/app_colors.dart';
import 'package:getx_structure/pages/movieDemo/upcoming_movies/upcoming_movies_controller.dart';

import '../../../constants/components.dart';
import '../../../routes/app_pages.dart';

class UpcomingMoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingMovieController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Movies List',
              style: TextStyle(
                  color: Colors.white)),
          elevation: 0,
        ),
        body: controller.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  controller.filterMovies(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.filteredMovies.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.movieDetail,arguments: [controller.filteredMovies[index].id]);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          child: CachedNetworkImage(
                            imageUrl: '$imageBaseUrl${controller.filteredMovies[index].backdropPath}',
                            fit: BoxFit.cover,
                            height: Get.height * 0.30,
                            width: Get.width,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent
                                    ])),
                          ),
                        ),
                        Positioned(
                            bottom: 12,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                controller
                                    !.filteredMovies[index].originalTitle??"",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}