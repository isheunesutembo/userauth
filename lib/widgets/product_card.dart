import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:userauth/controllers/productscontroller.dart';
import 'package:userauth/models/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/views/product_details_screen.dart';
class ProductCard extends ConsumerWidget {
  ProductModel product;
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Stack(
      children: [
        Card(
          child: Column(
            children: [
              Image.network(
                product.fullImagePath,
                height: 180,
                width: 180,
                fit: BoxFit.fill,
              ),
              Text(
                product.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price!.toString()}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${product.oldPrice!.toString()}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                ref.read(productsController.notifier)
                .deleteProductById(product.productId!, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
            ))
      ],
    );
  }
}
