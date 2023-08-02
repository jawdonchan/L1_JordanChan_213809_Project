// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    String odataMetadata;
    List<Value> value;

    Welcome({
        this.odataMetadata,
        this.value,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        odataMetadata: json["odata.metadata"],
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
    };
}

class Value {
    String busStopCode;
    String roadName;
    String description;
    double latitude;
    double longitude;

    Value({
        this.busStopCode,
        this.roadName,
        this.description,
        this.latitude,
        this.longitude,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        busStopCode: json["BusStopCode"],
        roadName: json["RoadName"],
        description: json["Description"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "BusStopCode": busStopCode,
        "RoadName": roadName,
        "Description": description,
        "Latitude": latitude,
        "Longitude": longitude,
    };
     static List<Value> filterList(List<Value> vl, String filterString) {
    List<Value> _v = vl
    .where(
    (u) => (u.busStopCode.toString().split('.').last.toLowerCase()
    .contains(filterString.toLowerCase()))
    ).toList();
    return _v;
    }
}
