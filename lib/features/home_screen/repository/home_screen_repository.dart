import 'dart:convert';
import 'package:the_grandmerche/model/restaurant_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenRepository {
  Future<Restaurants> fetchRestaurants() async {
    Restaurants datas;
    try {
      final response = await http.get((Uri.parse(
          "https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
      print("status code");
      print(response.statusCode);
      print("body");
      if (response.statusCode == 110) {
        datas = Restaurants.fromJson(a);
        return datas;
      } else if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        datas = Restaurants.fromJson(data);
        return datas;
        // _resto = Restaurants.fromJson(data);
      } else {
        // "Failed to load data";
        datas = Restaurants.fromJson(a);
        return datas;
      }
    } catch (e) {
      print(e.toString());
      datas = Restaurants.fromJson(a);
      return datas;
    }
    // // try {
    // var ip = '192.19.170.13';
    // // setState(() => _isSubmitting = true);
    // http.Response response = await http.post(
    //     Uri.parse(
    //         'http://firstflight-web.ipixsolutions.net/api/getRestaurants'),
    //     /* I've also tried using localhost(it didn't work) everyone suggested to use my loopback adapter's (Ethernet's ip address) even that isn't working.*/
    //     body: {
    //       'username': "_username",
    //       'email': "_email",
    //       'password': "_password",
    //     });
    //
    // final responseData = json.decode(response.body);
    // datas = Restaurants.fromJson(responseData);
    // // setState(() => _isSubmitting = false);
    // // _successSnackBar();
    // print(responseData);
    // // return datas;
    // // } catch (e) {
    // // setState(() => _isSubmitting = false);
    // // print(e.toString());
    // // datas = Restaurants.fromJson(a);
    // // return datas;
    // // }
    // return datas;
  }
}
