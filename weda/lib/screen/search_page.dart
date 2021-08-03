import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:weda/config/template.dart';
import 'package:weda/config/dataformat.dart';
import 'view.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Body()),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  StreamSubscription<ConnectivityResult> subscription;
  bool connection;
  var data;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        showSnackBar();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
  }

  void showSnackBar() {
    SnackBar message = SnackBar(content: Text('No Connection'));
    ScaffoldMessenger.of(context).showSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth(context),
        height: screenHeight(context),
        color: Colors.blue.withOpacity(0.1),
        child: Column(
          children: [
            SizedBox(height: 200),
            Text(
              "WEATHER APP",
              style: TextStyle(fontFamily: "FreckleFace", fontSize: 50),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: Search());
              },
              child: Container(
                height: 50,
                width: screenWidth(context) - 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Search for a city"), Icon(Icons.search)],
                ),
              ),
            )
          ],
        ));
  }
}

class Search extends SearchDelegate<String> {
  final List<String> _data = [
    "Abuja",
    "Lagos",
    "Port-Harcout",
    "Benin",
    "Kano",
    "Kaduna",
    "Nassarawa",
    "Kogi"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchData(query),
      child: FutureBuilder(
          future: fetchData(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return View(data: snapshot.data);
              } else if (snapshot.hasError) {
                return Container(
                  child: Center(child: Text('No Network')),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? ["Taraba", "Sokoto", "Delta"]
        : _data.where((i) => i.startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          final String suggestion = suggestions[index];
          return ListTile(
              onTap: () {
                query = suggestion;
                showResults(context);
              },
              leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
              title: query.isEmpty
                  ? Text(suggestion)
                  : RichText(
                      text: TextSpan(
                          text: suggestion.substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                          TextSpan(
                              text: suggestion.substring(query.length),
                              style: TextStyle(fontWeight: FontWeight.w300))
                        ])));
        });
  }
}
