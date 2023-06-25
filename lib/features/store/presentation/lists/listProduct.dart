import 'package:ur_provider/features/inventory/domain/entities/product.dart';
class listProducts {

  static List<Product> listProduct(List<dynamic> listJson){
    List<Product> listadoProduct=[];
    if(listJson!=null){
      for(var p in listJson){
        final pos=Product.objJson(p);
        listadoProduct.add(pos);
      }
    }
    return listadoProduct;

  }
}