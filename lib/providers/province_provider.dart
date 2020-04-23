import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/detail_coutry.dart';

class ProvinceProvider with ChangeNotifier {
  var api = ApiServices();
  DetailCountry province;

  Future<DetailCountry> getProviceProvider(String id) async {
    final response = await api.client.get("${api.baseUrl}/api/countries/$id");
    if (response.statusCode == 200) {
      notifyListeners();
      var res = detailCountryFromJson(response.body);
      province = res;
      return province;
    } else {
      return null;
    }
  }
}