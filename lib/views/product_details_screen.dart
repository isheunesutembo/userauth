import 'package:flutter/material.dart';
import 'package:userauth/models/productmodel.dart';
import 'package:userauth/views/edit_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product=ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title:const Text("Product Details",
        style: TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
        actions: [
          GestureDetector(onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditProductScreen(),settings: RouteSettings(arguments: product)));

          },child:const  Padding(
            padding:EdgeInsets.all(8.0),
            child:  Text("Edit Product", style: TextStyle(color:Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
          ))
        ],
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,children: [
          Image.network(product.fullImagePath,
          height: 200,
          width: double.infinity,),
      const   Padding(
           padding:  EdgeInsets.all(8.0),
           child:  Divider(thickness: 1,color: Colors.black,),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(product.title!,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
         ),
       const  Padding(
           padding:  EdgeInsets.all(8.0),
           child:  Divider(thickness: 1,color: Colors.black,),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(product.description!,style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400)),
         ),
          const Divider(thickness: 1,color: Colors.black,),
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

        ],),
      )),
    );
  }
}