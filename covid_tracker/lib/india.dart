import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<List> dataes;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
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
        title: Text('Countries Statistics!'),
        backgroundColor:  Color(0xFF292929),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
              future: dataes,
              builder: (BuildContext context, SnapShot) {
                if (SnapShot.hasData) {
                  return ListView.builder(
                    itemCount: 36,
                    itemBuilder: (BuildContext context, index) => SizedBox(
                            height: 150,
                            child: Card(
                              color: Color(0xFF292929),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${SnapShot.data[index]['loc']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Total Cases",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${SnapShot.data[index]['confirmedCasesIndian']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          )
                  );
                }

                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
