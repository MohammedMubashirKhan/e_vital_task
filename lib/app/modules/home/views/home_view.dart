import 'dart:developer';

import 'package:e_vital_task/app/modules/home/model/user.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          controller: controller.scrollController,
          // itemCount: controller.displayedUsers.length +
          //     1, // +1 for the loading indicator
          itemCount: controller.displayedUsers.length +
              (controller.hasMoreData.value
                  ? 1
                  : 0), // Include loading indicator only if there's more data

          itemBuilder: (context, index) {
            log("index: $index");
            if (index == controller.displayedUsers.length &&
                controller.hasMoreData.value) {
              return _buildLoadingIndicator();
            }
            return _buildUserTile(controller.displayedUsers[index]);
          },
        ),
      ),
    );
  }

  Widget _buildUserTile(User user) {
    return ListTile(
      leading: Image.network(user.imageUrl),
      title: Text(user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.phoneNumber),
          Text(user.city),
          Text(user.stock > 50 ? 'Stock: High' : 'Stock: Low'),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
