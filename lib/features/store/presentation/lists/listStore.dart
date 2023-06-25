

import 'package:ur_provider/features/store/domain/entities/store.dart';

class listStores {

  static List<store> listStore(List<dynamic> listJson){
    List<store> listadoStores=[];
    if(listJson!=null){
      for(var p in listJson){
        final pos=store.objJson(p);
        listadoStores.add(pos);
      }
    }
    return listadoStores;

  }
}