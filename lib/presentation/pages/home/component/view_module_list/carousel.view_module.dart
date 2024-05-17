import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/theme/constant/app_colors.dart';
import '../../../../../domain/model/display/product_info/product_info.model.dart';
import '../../../../../domain/model/display/view_module/view_module.model.dart';

class CarouselViewModule extends StatefulWidget {
  const CarouselViewModule({super.key, required this.info});

  final ViewModule info;

  @override
  State<CarouselViewModule> createState() => _CarouselViewModuleState();
}

class _CarouselViewModuleState extends State<CarouselViewModule> {
  late Timer _timer;
  PageController pageController = PageController();
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = periodicTimer();
  }

  Timer periodicTimer() {
    return Timer.periodic(Duration(seconds: 4), (timer) {
      pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductInfo> products = widget.info.products;
    return AspectRatio(
      aspectRatio: 375 / 340,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentPage = (value % products.length) + 1;
              });
            },
            itemBuilder: (context, index) {
              String src = products[index % products.length].imageUrl;

              return Image.network(
                src,
                fit: BoxFit.cover,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageCountWidget(
                currentPage: currentPage,
                totalPage: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageCountWidget extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  const PageCountWidget({super.key, required this.currentPage, required this.totalPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.74),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Text(
        '$currentPage / $totalPage',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
