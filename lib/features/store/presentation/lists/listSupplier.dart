import 'package:ur_provider/features/providers/domain/domain.dart';

class listSuppliers {

  static List<Supplier> listSupplier(List<dynamic> listJson){
    List<Supplier> listadoSupplier=[];
    if(listJson!=null){
      for(var p in listJson){
        final pos=Supplier.objJson(p);
        listadoSupplier.add(pos);
      }
    }
    return listadoSupplier;

  }
}