import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trufi_core/blocs/preferences_bloc.dart';

import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import '../trufi_configuration.dart';
import '../trufi_map_utils.dart';
import '../widgets/trufi_map.dart';

typedef LayerOptionsBuilder = List<LayerOptions> Function(BuildContext context);

class TrufiOnlineMap extends StatefulWidget {
  TrufiOnlineMap({
    Key key,
    @required this.controller,
    @required this.layerOptionsBuilder,
    this.onTap,
    this.onLongPress,
    this.onPositionChanged,
  }) : super(key: key);

  final TrufiMapController controller;
  final LayerOptionsBuilder layerOptionsBuilder;
  final TapCallback onTap;
  final LongPressCallback onLongPress;
  final PositionCallback onPositionChanged;

  @override
  TrufiOnlineMapState createState() => TrufiOnlineMapState();
}

class TrufiOnlineMapState extends State<TrufiOnlineMap> {

  StreamSubscription<List<Marker>> markersSubscription;
  List<Marker> showingMarkers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      markersSubscription = WheelchairLayer().markers.listen((value) {
        refresMarkers(widget.controller.mapController.bounds, widget.controller.mapController.zoom);
      });
    });
  }

  void refresMarkers(LatLngBounds bounds, double zoom) {
    if (mounted && !bussy) {
      bussy = true;
      WheelchairLayer().filterMarkers(bounds, zoom).then((value) {
        if (mounted)
          setState(() {
            showingMarkers = value;
            bussy = false;
          });
      });
    }
  }

  @override
  void dispose() {
    markersSubscription?.cancel();
    super.dispose();
  }

  bool bussy = false;
  @override
  Widget build(BuildContext context) {
    final preferencesBloc = PreferencesBloc.of(context);
    final cfg = TrufiConfiguration();
    return StreamBuilder(
      stream: preferencesBloc.outChangeMapType,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TrufiMap(
          key: ValueKey("TrufiOnlineMap"),
          controller: widget.controller,
          mapOptions: MapOptions(
            minZoom: cfg.map.onlineMinZoom,
            maxZoom: cfg.map.onlineMaxZoom,
            zoom: cfg.map.onlineZoom,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            onPositionChanged: _handleOnPositionChanged,
            center: cfg.map.center,
          ),
          layerOptionsBuilder: (context) {
            return <LayerOptions>[
              tileHostingTileLayerOptions(
                getTilesEndpointForMapType(snapshot.data),
                tileProviderKey: cfg.map.mapTilerKey,
              ),
              MarkerLayerOptions(
            markers: showingMarkers,
          )
            ]..addAll(widget.layerOptionsBuilder(context));
          },
        );
      },
    );
  }

  void _handleOnPositionChanged(
    MapPosition position,
    bool hasGesture,
  ) {
    if (widget.onPositionChanged != null) {
      Future.delayed(Duration.zero, () {
        widget.onPositionChanged(position, hasGesture);
      });
      refresMarkers(position.bounds, position.zoom);
    }
  }
}
class WheelchairLayer {
  static WheelchairLayer _instance = WheelchairLayer._();

  Timer time;
  WheelchairLayer._() {
    _load();
  }

  factory WheelchairLayer() {
    return _instance;
  }
  start() {
    time?.cancel();
    time = Timer.periodic(Duration(minutes: 5), (Timer t) => _load());
  }

  final BehaviorSubject<List<Marker>> markers =
      BehaviorSubject<List<Marker>>.seeded([]);

  Future<void> _load() async {
    http.Response responses = await http.get(
      'http://88.99.240.176:3127/facilities',
    );
    if (responses.statusCode != 200) return;
    List body = json.decode(responses.body);
    List<Marker> response = [];
    for (Map element in body) {
      _Facility facility = _Facility.fromJSON(element);
      Marker marker = Marker(
        width: 30.0,
        height: 30.0,
        point: new LatLng(facility.geocoordY, facility.geocoordX),
        anchorPos: AnchorPos.align(AnchorAlign.center),
        builder: (ctx) => GestureDetector(
          onTap: () {},
          child: new Container(
            child: Center(
              child: Icon(
                facility.type == "ELEVATOR" ? Icons.elevator : Icons.stairs,
                color: facility.state ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
      );
      response.add(marker);
    }
    markers.add(response);
  }

  Future<List<Marker>> filterMarkers(LatLngBounds bounds, double zoom) async {
    List<Marker> response = [];
    for (Marker marker in markers.value) {
      bool out = bounds.isOverlapping(
        LatLngBounds(marker.point),
      );
      if (out && zoom > 10) {
        response.add(marker);
      }
    }
    await Future.delayed(Duration(milliseconds: 100));
    return response;
  }

  close() {
    time?.cancel();
    markers?.close();
  }
}

class _Facility {
  final int equipmentnumber;
  final String type;
  final String description;
  final double geocoordX;
  final double geocoordY;
  final bool state;
  final String stateExplanation;
  final int stationnumber;
  final String operatorName;
  _Facility.fromJSON(Map data)
      : this.equipmentnumber = data["equipmentnumber"],
        this.type = data["type"],
        this.description = data["description"],
        this.geocoordX = data["geocoordX"],
        this.geocoordY = data["geocoordY"],
        this.state = data["state"] == "ACTIVE",
        this.stateExplanation = data["stateExplanation"],
        this.stationnumber = data["stationnumber"],
        this.operatorName = data["operatorName"];
}
