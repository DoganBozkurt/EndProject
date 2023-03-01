// ignore_for_file: file_names
import 'dart:convert';
import 'package:usis_2/Model/AktifIsler.dart';
import 'package:usis_2/Model/op.dart';
import 'package:usis_2/Model/personel.dart';
import 'package:usis_2/Model/tezgah.dart';
import 'package:usis_2/constants.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Personel>?> getPersonel() async {
    var url = Uri.parse('$constUrl/api/personel');
    var response = await http.get(url, headers: {
      "Contet_Type": "applacition/json",
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return personelFromJson(json);
    }
    return null;
  }

  Future<List<Tezgah>?> getTezgah() async {
    var url = Uri.parse('$constUrl/api/tezgah');
    var response = await http.get(url, headers: {
      "Contet_Type": "applacition/json",
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return tezgahFromJson(json);
    }
    return null;
  }

  Future<List<Op>?> getOp() async {
    var url = Uri.parse('$constUrl/api/op');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return opFromJson(json);
    }
    return null;
  }

  Future<bool> postIsBaslat(Map mapVeriler) async {
    var url = Uri.parse('$constUrl/api/IsBaslat');
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "charset": "utf-8",
        },
        body: jsonEncode(mapVeriler));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
    Future<List<AktifIsler>?> getAktifIsler() async {
    var url = Uri.parse('$constUrl/api/AktifIsler');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return aktifIslerFromJson(json);
    }
    return null;
  }
}
