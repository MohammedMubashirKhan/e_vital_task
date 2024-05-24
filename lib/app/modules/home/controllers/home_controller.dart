import 'dart:math';

import 'package:e_vital_task/app/modules/home/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<User> allUsers = List.generate(
      43,
      (index) => User(
            name: 'User $index',
            phoneNumber: '1${index}3456789$index',
            city: 'City $index',
            imageUrl: 'https://source.unsplash.com/random?stocks&sig=$index',
            stock: Random().nextInt(100) % 100,
          ));

  final RxList<User> displayedUsers = <User>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  int itemsPerPage = 20;
  RxBool isLoading = false.obs;
  RxBool hasMoreData = true.obs;

  Future<void> loadMoreUsers() async {
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = true;

    final int nextPage = currentPage + 1;
    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;
    if (startIndex < allUsers.length) {
      displayedUsers.addAll(allUsers.sublist(
          startIndex, endIndex > allUsers.length ? allUsers.length : endIndex));
      currentPage = nextPage;
    }
    if (endIndex >= allUsers.length) {
      hasMoreData.value = false;
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value &&
          hasMoreData.value) {
        loadMoreUsers();
      }
    });

    loadMoreUsers();
  }

  void filterUsers(String query) {
    final filteredUsers = allUsers.where((user) {
      final nameLower = user.name.toLowerCase();
      final phoneLower = user.phoneNumber.toLowerCase();
      final cityLower = user.city.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) ||
          phoneLower.contains(queryLower) ||
          cityLower.contains(queryLower);
    }).toList();

    displayedUsers.clear();
    displayedUsers.addAll(filteredUsers);
  }

  void showUpdateDialog(User user) {
    final TextEditingController rupeeController =
        TextEditingController(text: user.stock.toString());

    Get.dialog(
      AlertDialog(
        title: Text('Update Rupee for ${user.name}'),
        content: TextField(
          controller: rupeeController,
          decoration: const InputDecoration(labelText: 'Rupee'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final int newStock =
                  int.tryParse(rupeeController.text) ?? user.stock;
              user.updateStock(newStock);
              displayedUsers
                  .refresh(); // Refresh the displayed users list to reflect the changes
              Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
