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
    String carParkId;
    Area area;
    String development;
    String location;
    int availableLots;
    LotType lotType;
    Agency agency;

    Value({
        this.carParkId,
        this.area,
        this.development,
        this.location,
        this.availableLots,
        this.lotType,
        this.agency,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        carParkId: json["CarParkID"],
        area: areaValues.map[json["Area"]],
        development: json["Development"],
        location: json["Location"],
        availableLots: json["AvailableLots"],
        lotType: lotTypeValues.map[json["LotType"]],
        agency: agencyValues.map[json["Agency"]],
    );

    Map<String, dynamic> toJson() => {
        "CarParkID": carParkId,
        "Area": areaValues.reverse[area],
        "Development": development,
        "Location": location,
        "AvailableLots": availableLots,
        "LotType": lotTypeValues.reverse[lotType],
        "Agency": agencyValues.reverse[agency],
    };
        static List<Value> filterList(List<Value> vl, String filterString) {
    List<Value> _v = vl
    .where(
    (u) => (u.area.toString().split('.').last.toLowerCase()
    .contains(filterString.toLowerCase()))
    ).toList();
    return _v;
    }
}

enum Agency { LTA, URA, HDB }

final agencyValues = EnumValues({
    "HDB": Agency.HDB,
    "LTA": Agency.LTA,
    "URA": Agency.URA
});

enum Area { MARINA, HARBFRONT, ORCHARD, JURONG_LAKE_DISTRICT, OTHERS, EMPTY }

final areaValues = EnumValues({
    "": Area.EMPTY,
    "Harbfront": Area.HARBFRONT,
    "JurongLakeDistrict": Area.JURONG_LAKE_DISTRICT,
    "Marina": Area.MARINA,
    "Orchard": Area.ORCHARD,
    "Others": Area.OTHERS
});

enum LotType { C, Y, H }

final lotTypeValues = EnumValues({
    "C": LotType.C,
    "H": LotType.H,
    "Y": LotType.Y
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
