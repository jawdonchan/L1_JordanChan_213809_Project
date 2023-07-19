// To parse this JSON data, do
//
//     final BusArrival = BusArrivalFromJson(jsonString);

import 'dart:convert';

BusArrival busArrivalFromJson(String str) => BusArrival.fromJson(json.decode(str));

String busArrivalToJson(BusArrival data) => json.encode(data.toJson());

class BusArrival {
    String odataMetadata;
    String busStopCode;
    List<Service> services;

    BusArrival({
        this.odataMetadata,
        this.busStopCode,
        this.services,
    });

    factory BusArrival.fromJson(Map<String, dynamic> json) => BusArrival(
        odataMetadata: json["odata.metadata"],
        busStopCode: json["BusStopCode"],
        services: List<Service>.from(json["Services"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "BusStopCode": busStopCode,
        "Services": List<dynamic>.from(services.map((x) => x.toJson())),
    };
}

class Service {
    String serviceNo;
    String serviceOperator;
    NextBus nextBus;
    NextBus nextBus2;
    NextBus nextBus3;

    Service({
        this.serviceNo,
        this.serviceOperator,
        this.nextBus,
        this.nextBus2,
        this.nextBus3,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceNo: json["ServiceNo"],
        serviceOperator: json["Operator"],
        nextBus: NextBus.fromJson(json["NextBus"]),
        nextBus2: NextBus.fromJson(json["NextBus2"]),
        nextBus3: NextBus.fromJson(json["NextBus3"]),
    );

    Map<String, dynamic> toJson() => {
        "ServiceNo": serviceNo,
        "Operator": serviceOperator,
        "NextBus": nextBus.toJson(),
        "NextBus2": nextBus2.toJson(),
        "NextBus3": nextBus3.toJson(),
    };
    static List<Service> filterList(List<Service> vl, String filterString) {
    List<Service> _v = vl
    .where(
    (u) => (u.serviceNo.toString().split('.').last.toLowerCase()
    .contains(filterString.toLowerCase()))
    ).toList();
    return _v;
    }
}

class NextBus {
    String originCode;
    String destinationCode;
    DateTime estimatedArrival;
    String latitude;
    String longitude;
    String visitNumber;
    Load load;
    Feature feature;
    Type type;

    NextBus({
        this.originCode,
        this.destinationCode,
        this.estimatedArrival,
        this.latitude,
        this.longitude,
        this.visitNumber,
        this.load,
        this.feature,
        this.type,
    });

    factory NextBus.fromJson(Map<String, dynamic> json) => NextBus(
        originCode: json["OriginCode"],
        destinationCode: json["DestinationCode"],
        estimatedArrival: DateTime.parse(json["EstimatedArrival"]),
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        visitNumber: json["VisitNumber"],
        load: loadValues.map[json["Load"]],
        feature: featureValues.map[json["Feature"]],
        type: typeValues.map[json["Type"]],
    );

    Map<String, dynamic> toJson() => {
        "OriginCode": originCode,
        "DestinationCode": destinationCode,
        "EstimatedArrival": estimatedArrival.toIso8601String(),
        "Latitude": latitude,
        "Longitude": longitude,
        "VisitNumber": visitNumber,
        "Load": loadValues.reverse[load],
        "Feature": featureValues.reverse[feature],
        "Type": typeValues.reverse[type],
    };
    static List<NextBus> filterList(List<NextBus> vl, String filterString) {
    List<NextBus> _v = vl
    .where(
    (u) => (u.originCode.toString().split('.').last.toLowerCase()
    .contains(filterString.toLowerCase()))
    ).toList();
    return _v;
    }
}

enum Feature { WAB }

final featureValues = EnumValues({
    "WAB": Feature.WAB
});

enum Load { SEA }

final loadValues = EnumValues({
    "SEA": Load.SEA
});

enum Type { SD, DD }

final typeValues = EnumValues({
    "DD": Type.DD,
    "SD": Type.SD
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
