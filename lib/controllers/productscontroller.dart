import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:userauth/models/productfiltermodel.dart';
import 'package:userauth/models/productmodel.dart';
import 'package:userauth/repository/productrepository.dart';
import 'package:userauth/state/product_state.dart';
import 'package:userauth/utils/utils.dart';

final productsController =
    NotifierProvider<ProductsController, ProductState>(ProductsController.new);
final getProducts = FutureProvider((ref) {
  final products = ref.watch(productsController.notifier);
  return products.getProducts();
});

class ProductsController extends Notifier<ProductState> {
  late ProductRepository _productRepository;
  late ProductFilterModel _productFilterModel;

  @override
  ProductState build() {
    _productRepository = ref.watch(productsRepositoryProvider);
    getProducts();
    return const ProductState();
  }

  int _page = 1;

  Future<void> createProduct(
      File image,
      String title,
      String description,
      double price,
      double oldPrice,
    
      BuildContext context) async {
    final res = await _productRepository.createProduct(
        image, title, description, price, oldPrice);

    final val = switch (res) {
      Left(value: final l) => showSnackBar(context, l.message),
      Right(value: final r) => showSnackBar(context, r.toString())
    };
  }

  Future<void> updateProduct(
      File image,
      String title,
      String description,
      double price,
      double oldPrice,
      String productId,
      BuildContext context) async {
    final res = await _productRepository.updateProduct(
        image, title, description, price, oldPrice, productId);

    final val = switch (res) {
      Left(value: final l) => showSnackBar(context, l.message),
      Right(value: final r) => showSnackBar(context, r.toString())
    };
  }

  Future<void> getProductById(String productId, BuildContext context) async {
    final res = await _productRepository.getProductById(productId);
    final val = switch (res) {
      Left(value: final l) => showSnackBar(context, l.message),
      Right(value: final r) => showSnackBar(context, r.toString())
    };
  }

  Future<void> deleteProductById(String productId, BuildContext context) async {
    final res = await _productRepository.deleteProducts(productId);
    final val = switch (res) {
      Left(value: final l) => showSnackBar(context, l.message),
      Right(value: final r) => showSnackBar(context, r.toString())
    };
  }

  Future<List<ProductModel>>getProducts()async{
    final res=await _productRepository
    .getProducts();

    return switch(res){
      Left(value:final l)=>throw l,
      Right(value:final r)=>r

    };

  }

/*
  Future<void> getProducts() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    state = state.copyWith(isLoading: true);
    var filter = _productFilterModel.copyWith(
        paginationModel: PaginationModel(page: _page, pageSize: 10));
    final products = await _productRepository.getProducts(filter);
    late final newProducts;
    final res = switch (products) {
      Right(value: final r) => newProducts = [state.products, ...r],
      Left(value: final l) => throw l
    };
    if (products.value.length % 10 != 0 || products.value.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    state = state.copyWith(products: newProducts);
    _page++;
    state = state.copyWith(isLoading: false);
  }
  */

/*
  Future<void> refreshProducts() async {
    state = state.copyWith(products: [], hasNext: false);
    _page = 1;
    await getProducts();
  }
  */
}
