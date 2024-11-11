import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userauth/models/paginationmodel.dart';
part 'productfiltermodel.freezed.dart';

@freezed
abstract class ProductFilterModel with _$ProductFilterModel{

  factory ProductFilterModel({
    required PaginationModel paginationModel,
    String? categoryId,
    String? sortBy
  })=_ProductFilterModel;
}