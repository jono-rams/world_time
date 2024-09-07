import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async {

    // make the request
    Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/Europe/London'));
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

  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('loading screen'),
    );
  }
}
