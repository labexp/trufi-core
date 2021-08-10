import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/pages/choose_location.dart';

import '../entities/plan_entity/plan_entity.dart';
import 'enums/defaults_location.dart';

abstract class TrufiPlace {}

class TrufiLocation implements TrufiPlace {
  TrufiLocation({
    @required this.description,
    @required this.latitude,
    @required this.longitude,
    this.alternativeNames,
    this.localizedNames,
    this.address,
    this.type,
  })  : assert(description != null),
        assert(latitude != null),
        assert(longitude != null);

  final String description;
  final double latitude;
  final double longitude;
  final List<String> alternativeNames;
  final Map<String, String> localizedNames;
  final String address;
  final String type;

  TrufiLocation copyWith({
    String description,
    double latitude,
    double longitude,
    List<String> alternativeNames,
    Map<String, String> localizedNames,
    String address,
    String type,
  }) {
    return TrufiLocation(
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      alternativeNames: alternativeNames ?? this.alternativeNames,
      localizedNames: localizedNames ?? this.localizedNames,
      address: address ?? this.address,
      type: type ?? this.type,
    );
  }

  factory TrufiLocation.fromChooseLocationDetail(
    ChooseLocationDetail chooseLocationDetail,
  ) {
    return TrufiLocation(
      description: chooseLocationDetail.description,
      address: chooseLocationDetail.street,
      latitude: chooseLocationDetail.location.latitude,
      longitude: chooseLocationDetail.location.longitude,
    );
  }

  factory TrufiLocation.fromLocationsJson(Map<String, dynamic> json) {
    return TrufiLocation(
      description: json['name'] as String,
      latitude: json['coords']['lat'] as double,
      longitude: json['coords']['lng'] as double,
    );
  }

  factory TrufiLocation.fromSearchPlacesJson(List<dynamic> json) {
    return TrufiLocation(
      description: json[0].toString(),
      alternativeNames: json[1].cast<String>() as List<String>,
      localizedNames: json[2].cast<String, String>() as Map<String, String>,
      longitude: json[3][0].toDouble() as double,
      latitude: json[3][1].toDouble() as double,
      address: json[4] as String,
      type: json[5] as String,
    );
  }

  factory TrufiLocation.fromPlanLocation(PlanLocation value) {
    return TrufiLocation(
      description: value.name,
      latitude: value.latitude,
      longitude: value.longitude,
    );
  }

  factory TrufiLocation.fromSearch(Map<String, dynamic> json) {
    return TrufiLocation(
      description: json['description'] as String,
      latitude: json['lat'] as double,
      longitude: json['lng'] as double,
    );
  }

  factory TrufiLocation.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TrufiLocation(
      description: json["description"] as String,
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
      type: json["type"] as String,
      address: json["address"] != null ? json["address"] as String : '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "type": type,
      "address": address ?? ''
    };
  }

  @override
  bool operator ==(Object o) =>
      o is TrufiLocation &&
      o.description == description &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.type == type;

  @override
  int get hashCode =>
      description.hashCode ^ latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return '$latitude,$longitude';
  }

  String displayName(
    TrufiLocalization localization,
  ) {
    String translate = description;
    if (type == DefaultLocation.defaultHome.initLocation.type) {
      translate = isLatLngDefined
          ? localization.defaultLocationHome
          : localization.defaultLocationAdd(localization.defaultLocationHome);
    } else if (type == DefaultLocation.defaultWork.initLocation.type) {
      translate = isLatLngDefined
          ? localization.defaultLocationWork
          : localization.defaultLocationAdd(localization.defaultLocationWork);
    }
    return translate;
  }

  bool get isLatLngDefined {
    return latitude != 0 && longitude != 0;
  }

  LatLng get latLng {
    return LatLng(latitude, longitude);
  }
}

class TrufiStreet implements TrufiPlace {
  TrufiStreet({@required this.location});

  final TrufiLocation location;
  final List<TrufiStreetJunction> junctions = [];

  factory TrufiStreet.fromSearchJson(List<dynamic> json) {
    return TrufiStreet(
      location: TrufiLocation(
        description: json[0] as String,
        alternativeNames: json[1].cast<String>() as List<String>,
        longitude: json[2][0].toDouble() as double,
        latitude: json[2][1].toDouble() as double,
      ),
    );
  }

  String get description => location.description;

  String displayName(TrufiLocalization localization) =>
      location.displayName(localization);
}

class TrufiStreetJunction {
  TrufiStreetJunction({
    @required this.street1,
    @required this.street2,
    @required this.latitude,
    @required this.longitude,
  });

  final TrufiStreet street1;
  final TrufiStreet street2;
  final double latitude;
  final double longitude;

  String get description {
    return '${street1.location.description} & ${street2.location.description}';
  }

  String displayName(TrufiLocalization localization) =>
      localization.instructionJunction(
        street1.location?.displayName,
        street2.location?.displayName,
      );

  TrufiLocation location(TrufiLocalization localization) {
    return TrufiLocation(
      description: displayName(localization),
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class LevenshteinObject<T> {
  LevenshteinObject(this.object, this.distance);

  final T object;
  final int distance;
}
