import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/controllers/productscontroller.dart';
import 'package:userauth/models/paginationmodel.dart';
import 'package:userauth/uitl/errortext.dart';
import 'package:userauth/uitl/loader.dart';
import 'package:userauth/widgets/product_card.dart';

/*
class ProductsScreen extends ConsumerWidget {
  final ScrollController _scrollController=ScrollController();
   ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState=ref.watch(productsController);
    
    _scrollController.addListener((){
   if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
   final products=ref.read(productsController.notifier);
   if(productState.hasNext){
    products.getProducts();
   }

   }
    });
    if(productState.products.isEmpty){
      if(!productState.hasNext&& !productState.isLoading){
        return const Center(
          child: Text("No Products"),
        );
      }
      return const Scaffold(body: SafeArea(child: LinearProgressIndicator()));
    }
    return RefreshIndicator(onRefresh: ()async{
      ref.read(productsController.notifier).refreshProducts();
    },child:GridView.count(crossAxisCount: 2,children: List.generate(productState.products.length, (index){
      return ProductCard(product: productState.products[index]);
    }),) ,);
  }
}
*/
