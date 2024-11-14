import 'package:fakestore_ufc/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
            width: mq.width * 0.7,
            child: Text(
              product.title!,
              softWrap: true,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.03,
          vertical: mq.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: mq.width,
              height: mq.height * 0.5,
              image: NetworkImage(product.image ??
                  "https://expressdeco.com.au/wp-content/uploads/2017/05/placeholder.jpg"),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Text(
              product.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Text(
              product.description!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Text(
              "Rs ${product.price.toString()}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 18),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Text(
              product.category.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
