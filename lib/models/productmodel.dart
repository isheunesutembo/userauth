import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userauth/config/appconfig.dart';
part 'productmodel.freezed.dart';
part 'productmodel.g.dart';
List<ProductModel>productsFromJson(dynamic str)=>
List<ProductModel>.from((str).map((e)=>ProductModel.fromJson(e)));
@freezed
abstract class ProductModel with _$ProductModel {
  factory ProductModel({
    String? title,
    String? image,
    String? description,
    double? price,
    double? oldPrice,
    String? productId,
  }) = _ProductModel;
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductExt on ProductModel{
  String get fullImagePath=>Appconfig.fullImageUrl+image!;
}
