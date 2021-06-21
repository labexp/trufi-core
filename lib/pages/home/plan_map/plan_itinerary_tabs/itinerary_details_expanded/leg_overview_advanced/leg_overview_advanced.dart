import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:trufi_core/blocs/configuration/configuration_cubit.dart';
import 'package:trufi_core/entities/plan_entity/plan_entity.dart';
import 'package:trufi_core/entities/plan_entity/utils/fare_utils.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/enums/defaults_location.dart';
import 'package:trufi_core/models/enums/enums_plan/enums_plan.dart';
import 'package:trufi_core/pages/home/plan_map/plan_itinerary_tabs/itinerary_details_expanded/leg_overview_advanced/ticket_information.dart';
import 'package:trufi_core/services/models_otp/fare_component.dart';

import 'bar_itinerary_details.dart';
import 'line_dash_components.dart';

class LegOverviewAdvanced extends StatefulWidget {
  final PlanItinerary itinerary;
  final void Function() onBackPressed;
  const LegOverviewAdvanced({
    Key key,
    @required this.itinerary,
    this.onBackPressed,
  }) : super(key: key);

  @override
  _LegOverviewAdvancedState createState() => _LegOverviewAdvancedState();
}

class _LegOverviewAdvancedState extends State<LegOverviewAdvanced> {
  bool loading = false;
  String fetchError;
  List<FareComponent> fares;
  List<FareComponent> unknownFares;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigurationCubit>().state;

    final localization = TrufiLocalization.of(context);
    final compresedLegs = widget.itinerary.compressLegs;
    // loadData();
    return Column(
      children: compresedLegs
          .asMap()
          .map<int, Widget>((index, itineraryLeg) {
            return MapEntry(
              index,
              Column(
                children: [
                  if (index == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            if (widget.onBackPressed != null)
                              BackButton(
                                onPressed: widget.onBackPressed,
                              ),
                            Expanded(
                              child: BarItineraryDetails(
                                itinerary: widget.itinerary,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        if (loading)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Skeleton(
                                    padding: 2,
                                    width: 170,
                                    height: 18,
                                    textColor: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  Skeleton(
                                    padding: 2,
                                    width: 170,
                                    height: 18,
                                    textColor: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Skeleton(
                                  padding: 2,
                                  height: 40,
                                  textColor: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        if (fares != null)
                          TicketInformation(
                            legs: compresedLegs,
                            fares: fares,
                            unknownFares: unknownFares,
                          ),
                        if (fares != null || loading)
                          const Divider(
                            color: Colors.grey,
                          ),
                        if (itineraryLeg.transportMode == TransportMode.walk)
                          Column(
                            children: [
                              DashLinePlace(
                                date: widget.itinerary.startTimeHHmm.toString(),
                                location: _getDisplayName(
                                    itineraryLeg.fromPlace.name, localization),
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: FittedBox(
                                      child: config.markers.fromMarker),
                                ),
                              ),
                              WalkDash(
                                leg: itineraryLeg,
                              ),
                            ],
                          )
                        else if (compresedLegs.length > 1)
                          TransportDash(
                              leg: itineraryLeg,
                              isFirstTransport: true,
                              isNextTransport:
                                  (itineraryLeg.endTime.millisecondsSinceEpoch -
                                              compresedLegs[index + 1]
                                                  .startTime
                                                  .millisecondsSinceEpoch)
                                          .abs() >=
                                      0)
                      ],
                    )
                  else if (itineraryLeg.transportMode == TransportMode.walk &&
                      index < compresedLegs.length - 1)
                    Column(
                      children: [
                        WalkDash(
                          leg: itineraryLeg,
                        ),
                        if (itineraryLeg.endTime.millisecondsSinceEpoch <
                            compresedLegs[index + 1]
                                .startTime
                                .millisecondsSinceEpoch)
                          WaitDash(
                            legBefore: itineraryLeg,
                            legAfter: compresedLegs[index + 1],
                          )
                      ],
                    )
                  else if (index < compresedLegs.length - 1)
                    Column(
                      children: [
                        TransportDash(
                            leg: itineraryLeg,
                            isNextTransport:
                                (itineraryLeg.endTime.millisecondsSinceEpoch -
                                            compresedLegs[index + 1]
                                                .startTime
                                                .millisecondsSinceEpoch)
                                        .abs() >=
                                    0),
                        if (itineraryLeg.endTime.millisecondsSinceEpoch <
                            compresedLegs[index + 1]
                                .startTime
                                .millisecondsSinceEpoch)
                          WaitDash(
                            legBefore: itineraryLeg,
                            legAfter: compresedLegs[index + 1],
                          )
                      ],
                    ),
                  if (index == compresedLegs.length - 1)
                    Column(
                      children: [
                        if (itineraryLeg.transportMode == TransportMode.walk &&
                            compresedLegs.length > 1)
                          WalkDash(leg: itineraryLeg)
                        else if (itineraryLeg.transportMode !=
                            TransportMode.walk)
                          TransportDash(
                            leg: itineraryLeg,
                          ),
                        DashLinePlace(
                          date: widget.itinerary.endTimeHHmm.toString(),
                          location: _getDisplayName(
                              itineraryLeg.toPlace.name, localization),
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child: FittedBox(child: config.markers.toMarker)),
                        ),
                      ],
                    ),
                ],
              ),
            );
          })
          .values
          .toList(),
    );
  }

  String _getDisplayName(String name, TrufiLocalization localization) {
    if (name == DefaultLocation.defaultHome.keyLocation) {
      return localization.defaultLocationHome;
    } else if (name == DefaultLocation.defaultWork.keyLocation) {
      return localization.defaultLocationWork;
    }
    return name;
  }

  Future<void> loadData() async {
    if (widget.itinerary.compressLegs.isNotEmpty &&
        widget.itinerary.compressLegs.any((leg) => leg.transitLeg)) {
      if (!mounted) return;
      setState(() {
        fetchError = null;
        loading = true;
      });
      fetchFares(widget.itinerary).then((value) {
        if (mounted) {
          setState(() {
            fares = getFares(value);
            unknownFares = getUnknownFares(
                value, fares, getRoutes(widget.itinerary.compressLegs));
            loading = false;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            fetchError = "$error";
            loading = false;
          });
        }
      });
    }
  }
}
