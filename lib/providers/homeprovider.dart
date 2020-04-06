import '../models/home_model.dart';
import '../services/api_services.dart';
import 'package:flutter/material.dart';


class HomeProvider with ChangeNotifier {
  var api = ApiServices();
  HomeModel home;

  Future<HomeModel> getHomeProvider()async{
    // print api baseUrl
    final response = await api.client.get("${api.baseUrl}/api");
    if (response.statusCode == 200) {
      notifyListeners();
      var res = homeModelFromJson(response.body);
      home = res;
      return res;
    }else{
      return null;
    }
  }
}