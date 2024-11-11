

import 'package:userauth/models/paginationmodel.dart';
import 'package:userauth/models/productfiltermodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final productFilterNotifier=NotifierProvider<ProductFilterNotifier,ProductFilterModel>(ProductFilterNotifier.new);
class ProductFilterNotifier extends Notifier<ProductFilterModel>{
   ProductFilterModel build(){
    return ProductFilterModel(paginationModel: PaginationModel(page: 0, pageSize: 10));
   }
   void setProductFilter(ProductFilterModel productFilterModel){
   state=productFilterModel;
   }
}