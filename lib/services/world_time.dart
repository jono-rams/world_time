import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  late String time; // the time of the location
  String flag; // url to asset flag icon
  String url; // location url for api endpoint

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data["datetime"];

      // Get Sign
      String sign = data['utc_offset'].substring(0, 1);

      String offset1 = '00';
      String offset2 = '00';

      if (sign == '+')
      {
        offset1 = data['utc_offset'].substring(1,3);
        offset2 = data['utc_offset'].substring(4,6);
      }
      else
      {
        offset1 = data['utc_offset'].substring(0,3);
        offset2 = data['utc_offset'].substring(4,6);
      }

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      // Set the time property
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Error: $e');
      time = 'Could not get time data';
    }

  }

}
