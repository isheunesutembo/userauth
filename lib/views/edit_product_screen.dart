import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userauth/controllers/productscontroller.dart';
import 'package:userauth/models/productmodel.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  const EditProductScreen({super.key});

  @override
  ConsumerState<EditProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<EditProductScreen> {
  File? image;
  final title = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final oldPrice = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    description.dispose();
    price.dispose();
    oldPrice.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      throw 'Failed to pick image';
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    title.text = product.title!;
    description.text = product.description!;
    oldPrice.text = product.oldPrice.toString();
    price.text = product.price.toString();
    final updateProducts = ref.read(productsController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Product",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: image != null
                              ? Image.file(
                                  image!,
                                  height: 150,
                                  width: 150,
                                )
                              : Image.network(
                                  product.fullImagePath,
                                  height: 150,
                                  width: 150,
                                ),
                        ),
                      ),
                      const Text(
                        "Pick Product Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      initialValue: title.text,
                      enableSuggestions: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        title.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        hintText: "Product Title",
                        hintStyle: const TextStyle(color: Colors.black),
                        alignLabelWithHint: true,
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "product title cannot be empty";
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: TextFormField(
                        initialValue: description.text,
                        enableSuggestions: true,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          description.text = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          hintText: "Product Description",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 80, horizontal: 5),
                          hintStyle: const TextStyle(color: Colors.black),
                          alignLabelWithHint: true,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "product name cannot be empty";
                          }
                          return null;
                        }),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      initialValue: oldPrice.text,
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        oldPrice.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        hintText: "Old Price",
                        hintStyle: const TextStyle(color: Colors.black),
                        alignLabelWithHint: true,
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "product price cannot be empty";
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      initialValue: price.text,
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        price.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        hintText: "new price",
                        hintStyle: const TextStyle(color: Colors.black),
                        alignLabelWithHint: true,
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "product price cannot be empty";
                        }
                        return null;
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          updateProducts.updateProduct(
                              image!,
                              title.text,
                              description.text,
                              double.parse(price.text),
                              double.parse(oldPrice.text),
                              product.productId!,
                              context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          "Upload Product",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ))),
    );
  }
}
