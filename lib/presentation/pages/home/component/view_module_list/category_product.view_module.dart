import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/constant/app_icons.dart';
import '../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../domain/model/display/view_module/view_module.model.dart';
import 'view_module_factory/view_module_widget.dart';
import 'widget/product_card.component.dart';
import 'widget/view_module_padding.dart';
import 'widget/view_module_title.dart';

class CategoryProduct extends StatefulWidget with ViewModuleWidget {
  final ViewModule info;
  const CategoryProduct({super.key, required this.info});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.info.tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final info = widget.info;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewModulePadding(
          child: ViewModuleTitle(title: info.title),
        ),
        SizedBox(
          height: 12,
        ),
        TabBar(
          tabs: List.generate(
            info.tabs.length,
            (index) => Tab(
              text: info.tabs[index],
            ),
          ),
          controller: _tabController,
          isScrollable: true,
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: 13,
          ),
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: Constants.horizontalPadding,
          child: AspectRatio(
            aspectRatio: 343 / 452,
            child: TabBarView(
              controller: _tabController,
              children: List.generate(info.tabs.length, (index) {
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8,
                    childAspectRatio: ((343 - 16) / 3) / ((462 - 12) / 2),
                  ),
                  itemBuilder: (_, index) {
                    final productInfo = info.products[index];
                    return SmallProductCard(context: context, productInfo: productInfo);
                  },
                  itemCount: info.products.length,
                );
              }),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: Constants.horizontalPadding,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.chevronRight,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(colorScheme.contentPrimary, BlendMode.srcIn),
                ),
                Text(
                  '${info.tabs[_tabController.index]} 전체보기',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(
                        color: colorScheme.contentPrimary,
                      )
                      .regular,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
