import 'dart:convert';
import 'package:covid_tracker/india.dart';
import 'package:covid_tracker/model/TotalCases.dart';
import 'world.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/TotalCases.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://coronavirus-19-api.herokuapp.com/all";

  Future<Tcases> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);

      return Tcases.fromJson(convertDataJson);
    } else {
      throw Exception('try to Reload');
    }
  }

  void iniState() {
    super.initState();
    this.iniState();
  }

  navigateToCountry() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => World()));
  }

  navigateToStates() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => India()));
  }

  navigateToUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Text("Link is not Working $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Stay Home!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<Tcases>(
                future: getJsonData(),
                builder: (BuildContext content, SnapShot) {
                  if (SnapShot.hasData) {
                    final covid = SnapShot.data;
                    return Column(children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Card(
                            color: Color(0xFF292929),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 100,
                              width: 150,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "${covid.cases}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text("Total Cases",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green))
                                  ]),
                            ),
                          ),
                          Card(
                            color: Color(0xFF292929),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 100,
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "${covid.deaths}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "Total deaths",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Color(0xFF292929),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 100,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "${covid.recoverd}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              Text(
                                "Total Recovered",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Card(
                              color: Color(0xFF292929),
                              child: Container(
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "India",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                      OutlineButton(
                                        onPressed: () => navigateToStates(),
                                        child: Text(
                                          "Indian Statistics",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Card(
                              color: Color(0xFF292929),
                              child: Container(
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "World",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                      OutlineButton(
                                        onPressed: () => navigateToCountry(),
                                        child: Text(
                                          "World Statistics",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
               SizedBox(
              height: 20,
            ),     


            Card(
              color: Color(0xFF292929),
              child: Container(
                  height: 50,
                  width: 200,
                  child: OutlineButton(
                    onPressed: () => navigateToUrl(
                        "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/question-and-answers-hub/q-a-detail/q-a-coronaviruses"),
                    child: Text(
                      "WHO Link",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  )),
            ),


                    ]);
                  } else if (SnapShot.hasError) {
                    return Text(SnapShot.error.toString());
                  } else
                    return CircularProgressIndicator();
                }),
            // "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/question-and-answers-hub/q-a-detail/q-a-coronaviruses"
          ],
        ),
      ),
    );
  }
}
