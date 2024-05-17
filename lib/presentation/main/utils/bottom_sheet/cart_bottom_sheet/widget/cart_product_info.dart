import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../bloc/cart_bloc/cart_bloc.dart';

const double _imageSize = 48;

class CartProductInfo extends StatelessWidget {
  const CartProductInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productInfo = context.watch<CartBloc>().state.productInfo;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image.network(productInfo.imageUrl, height: _imageSize, width: _imageSize),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productInfo.title,
                  style: Theme.of(context).textTheme.titleSmall?.titleCopywith(),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  productInfo.subTitle,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
