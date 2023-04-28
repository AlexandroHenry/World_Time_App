// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location Name For UI
  String? time; // The Time in That Location
  String flag; // url to an asset flag icon
  String url; // Location URL for API Endpoint
  bool? isDayTime; // true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    String endpoint = "http://worldtimeapi.org/api/timezone/$url";
    Uri uri = Uri.parse(endpoint);
    try {
      // make the request
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DataTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      // time = now.toString();
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error: $e');
      time = 'could not get time data';
    }
  }
}
