import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  var currentPage = 0.obs;
  Timer? _timer;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    _startAutoSlide();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int nextPage = currentPage.value + 1;
      if (nextPage >= 2) { // 여기서 2는 페이지 수를 의미합니다
        nextPage = 0;
      }
      currentPage.value = nextPage;
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  void changePage(int index) {
    currentPage.value = index;
    _timer?.cancel();
    _startAutoSlide();
  }
}
