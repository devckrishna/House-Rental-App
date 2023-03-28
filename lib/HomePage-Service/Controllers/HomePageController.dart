import 'dart:convert';

import 'package:get/get.dart';
import 'package:house_rental_app/Constants.dart';
import 'package:house_rental_app/HomePage-Service/Models/Properties.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HomePageController extends GetxController {
  late LocationData _currentPosition;
  late String _address;
  Location location = new Location();
  RxString homePageState = "RENT".obs;
  var properties = <Properties>[].obs;
  var nearYourLocation = <Properties>[].obs;
  var topRatedProperties = <Properties>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPropertiesNearYou();
    getTopRatedProperties();
    fetchLocation();
  }

  toggleState() {
    if (homePageState.value == "RENT") {
      homePageState.value = "BUY";
    } else {
      homePageState.value = "RENT";
    }
  }

  void getAllProperties() async {
    var response = await http.get(
      Uri.parse(BASE_URL + GET_ALL_PROPERTIES_REQUEST),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    Data data = Data.fromJson(jsonDecode(response.body)["data"]);
    // print(jsonDecode(response.body)["data"]["properties"]);
    properties.assignAll(data.properties as Iterable<Properties>);
    print(properties.value[1].country);
  }

  void getPropertiesNearYou() async {
    var response = await http.post(
      Uri.parse(BASE_URL + GET_PROPERTIES_NEAR_YOU_REQUEST),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode(<String, dynamic>{"city": "Delhi", "country": "Pakistam"}),
    );

    // print(jsonDecode(response.body)["data"]);
    Data data = Data.fromJson(jsonDecode(response.body)["data"]);
    nearYourLocation.assignAll(data.properties as Iterable<Properties>);
    // print(nearYourLocation.value[0].title);
  }

  void getTopRatedProperties() async {
    var response = await http.post(
      Uri.parse(BASE_URL + GET_TOP_RATED_PROPERTIES),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode(<String, dynamic>{"city": "Delhi", "country": "Pakistam"}),
    );

    // print(jsonDecode(response.body));
    Data data = Data.fromJson(jsonDecode(response.body)["data"]);
    topRatedProperties.assignAll(data.properties as Iterable<Properties>);
    // print(topRatedProperties.value[0].title);
  }

  void fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _currentPosition = currentLocation;
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);
      // getAddress(_currentPosition.latitude, _currentPosition.longitude)
      //     .then((value) {
      //   setState(() {
      //     _address = "＄{value.first.addressLine}";
      //   });
      // });
    });
  }
}
