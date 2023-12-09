import 'package:responsi/basenetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> kategori() {
return BaseNetwork.get("categories.php");
}
 Future<Map<String, dynamic>> meal(String idCategory ) {
return BaseNetwork.get("filter.php?c=$idCategory");
}
 Future<Map<String, dynamic>> detail(String idMeals ) {
return BaseNetwork.get("lookup.php?i=$idMeals");
}


  loadDetaiUser(int idUser) {}

  getCategory() {}

}