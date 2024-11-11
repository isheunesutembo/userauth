import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/controllers/productscontroller.dart';
import 'package:userauth/uitl/errortext.dart';
import 'package:userauth/uitl/loader.dart';
import 'package:userauth/views/add_product_screen.dart';
import 'package:userauth/views/product_details_screen.dart';
import 'package:userauth/widgets/product_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProducts);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: products.when(
          data: (data) {
            return RefreshIndicator(
              color: Colors.green,
              onRefresh: ()=>ref.refresh(getProducts.future),
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductDetailsScreen(),settings: RouteSettings(arguments:data[index] )));
                    },child: ProductCard(product: data[index]));
                  }),
            );
          },
          error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
          loading: () => const Loader()),
    );
  }
}
