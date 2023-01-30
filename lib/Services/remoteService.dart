import 'package:usis_2/Model/personel.dart';
import 'package:usis_2/constants.dart';
import 'package:http/http.dart' as http;
class RemoteService {

  Future<List<Personel>?> getPersonel() async {
    var url = Uri.parse('$constUrl/api/personel');
    var response=await http.get(url,headers: {
      "Contet_Type": "applacition/json",
    });
    if (response.statusCode==200) {
       var json = response.body;
      return personelFromJson(json);
    }
    return null;
  }
  
}
