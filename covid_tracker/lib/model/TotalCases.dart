class Tcases {
  var cases;
  var deaths;
  var recoverd;

  Tcases({this.cases, this.deaths, this.recoverd});

  factory Tcases.fromJson(final json) {
    return Tcases(
        cases: json["cases"],
        deaths: json['deaths'],
        recoverd: json['recovered']);
  }
}
