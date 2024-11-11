
import 'package:userauth/models/productmodel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userauth/config/appconfig.dart';
part 'productsortmodel.freezed.dart';

@freezed
class ProductSortModel with _$ProductSortModel{
  factory ProductSortModel
  ({
    String? label,
    String? value
  })=_ProductSortModel;
}