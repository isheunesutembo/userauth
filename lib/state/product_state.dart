

import 'package:userauth/models/productmodel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userauth/config/appconfig.dart';
part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState{
  const factory ProductState({
    @Default(<ProductModel>[])List<ProductModel>products,
    @Default(true)bool hasNext,
    @Default(false)bool isLoading
  })=_ProductState;
}