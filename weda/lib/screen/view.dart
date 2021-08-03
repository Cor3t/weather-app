import 'package:flutter/material.dart';
import 'package:weda/config/dataformat.dart';
import 'package:intl/intl.dart';

class View extends StatelessWidget {
  final DataFormat data;
  View({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ViewBody(
      data: data,
    )));
  }
}

class ViewBody extends StatelessWidget {
  final DataFormat data;
  ViewBody({this.data});

  @override
  Widget build(BuildContext context) {
    Container bar = Container(height: 25, width: 1, color: Colors.black);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(data.current.isDay == 1
                  ? "assets/day.jpg"
                  : "assets/night.jpg"))),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text("${data.location.name}, ${data.location.country}",
                    style: TextStyle(fontSize: 35)),
                Text(
                  data.location.locatime,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 250),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https:${data.current.condition.icon}",
                    ),
                    Text(
                      "${data.current.temperature.toInt()}\u00B0c",
                      style: TextStyle(fontSize: 60),
                    ),
                  ],
                ),
                Text(
                  data.current.condition.weatherDescription,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                    'Updated as of ${DateFormat.Hm().format(DateTime.parse(data.current.observationTime))}'),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttomRow(
                        title: "PRESSURE",
                        value: data.current.pressure.toString()),
                    bar,
                    buttomRow(
                        title: "HUMIDITY", value: "${data.current.humidity}%"),
                    bar,
                    buttomRow(
                        title: "WIND", value: data.current.wind.toString()),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buttomRow({String title, String value}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(title),
          Text(value, style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}
