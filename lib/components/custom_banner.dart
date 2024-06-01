import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/dto/banner_controller.dart';

class CustomBanner extends StatelessWidget {
  final BannerController bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 2),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  PageView(
                    controller: bannerController.pageController,
                    onPageChanged: (int page) {
                      bannerController.changePage(page);
                    },
                    children: [
                      buildBanner('광고 1', 0),
                      buildBanner('광고 2', 1),
                    ],
                  ),
                  Obx(() => Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0), // 높이
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (i) => Container( // 개수
                          margin: EdgeInsets.all(2.0), // 간격
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bannerController.currentPage.value == i
                                ? Color(0xFFffffff)
                                : Color(0xFFffffff).withOpacity(0.5),
                          ),
                        )),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(String text, int index) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: appBarColor,
      ),
      child: Center(child: Text(text)),
    );
  }
}
