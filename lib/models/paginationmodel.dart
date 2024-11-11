import 'package:freezed_annotation/freezed_annotation.dart';
part 'paginationmodel.freezed.dart';

@freezed
abstract class PaginationModel with _$PaginationModel{
  factory PaginationModel({
    required int page,
    required int pageSize
  })=_PaginationModel;
}