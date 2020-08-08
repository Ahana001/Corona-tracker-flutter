import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  final String url = "https://coronavirus-19-api.herokuapp.com/countries";

  Future<List> dataes;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data;
  }

  Future showCard(String cases, tdeath, death, recover) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    "Total Cases: $cases",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Total Today's Death: $tdeath",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                  Text(
                    "Total Deaths: $death",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Text(
                    "Total Recovered: $recover",
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    dataes = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countries Statistics!",
        ),
        backgroundColor: Color(0xFF292929),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
              future: dataes,
              builder: (BuildContext context, SnapShot) {
                if (SnapShot.hasData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1),
                      itemCount: 215,
                      itemBuilder: (BuildContext context, index) => SizedBox(
                            height: 50,
                            width: 50,
                            child: GestureDetector(
                              onTap: () => showCard(
                                SnapShot.data[index]['cases'].toString(),
                                SnapShot.data[index]['deaths'].toString(),
                                SnapShot.data[index]['todayDeaths'].toString(),
                                SnapShot.data[index]['recovered'].toString(),
                              ),
                              child: Card(
                                child: Container(
                                  color: Color(0xFF292929),
                                  child: Center(
                                    child: Text(
                                      SnapShot.data[index]['country'],
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ));
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
