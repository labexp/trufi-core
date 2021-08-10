import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/trufi_place.dart';
import 'package:trufi_core/utils/util_icons/icons.dart';
import 'package:trufi_core/widgets/dialog_edit_text.dart';

import '../choose_location.dart';
import 'dialog_select_icon.dart';

class LocationTiler extends StatelessWidget {
  const LocationTiler({
    Key key,
    @required this.location,
    @required this.updateLocation,
    this.removeLocation,
    this.isDefaultLocation = false,
    this.enableSetIcon = false,
    this.enableSetName = false,
    this.enableSetPosition = false,
  }) : super(key: key);

  final TrufiLocation location;
  final bool isDefaultLocation;
  final bool enableSetIcon;
  final bool enableSetName;
  final bool enableSetPosition;
  final Function(TrufiLocation, TrufiLocation) updateLocation;
  final Function(TrufiLocation) removeLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = TrufiLocalization.of(context);
    return GestureDetector(
      onTap: () {
        if (!location.isLatLngDefined) {
          _changePosition(context);
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  typeToIconData(location.type) ?? Icons.place,
                )),
            Expanded(
              child: Text(
                location.displayName(localization),
                style: theme.textTheme.bodyText1
                    .copyWith(color: theme.primaryColor),
                maxLines: 1,
              ),
            ),
            if (location.isLatLngDefined)
              PopupMenuButton<int>(
                itemBuilder: (BuildContext context) => [
                  if (enableSetIcon)
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        localization.savedPlacesSetIconLabel,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  if (enableSetName)
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        localization.savedPlacesSetNameLabel,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  if (enableSetPosition)
                    PopupMenuItem(
                      value: 3,
                      child: Text(
                        localization.savedPlacesSetPositionLabel,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  if (removeLocation != null || location.isLatLngDefined)
                    PopupMenuItem(
                      value: 4,
                      child: Text(
                        localization.savedPlacesRemoveLabel,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                ],
                onSelected: (int index) async {
                  if (index == 1) {
                    await _changeIcon(context);
                  } else if (index == 2) {
                    await _changeName(context);
                  } else if (index == 3) {
                    await _changePosition(context);
                  } else if (index == 4) {
                    if (isDefaultLocation && location.isLatLngDefined) {
                      updateLocation(
                        location,
                        location.copyWith(
                          longitude: 0,
                          latitude: 0,
                        ),
                      );
                    } else {
                      if (removeLocation != null) {
                        removeLocation(location);
                      }
                    }
                  }
                },
              )
            else
              Container(
                height: 45,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeIcon(BuildContext context) async {
    final type = await showDialog<String>(
      context: context,
      builder: (context) => const DialogSelectIcon(),
    );
    updateLocation(location, location.copyWith(type: type));
  }

  Future<void> _changeName(BuildContext context) async {
    final String description = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogEditText(initText: location.description);
        });
    updateLocation(location, location.copyWith(description: description));
  }

  Future<void> _changePosition(BuildContext context) async {
    final ChooseLocationDetail chooseLocationDetail =
        await ChooseLocationPage.selectPosition(
      context,
      position: location.isLatLngDefined
          ? LatLng(location.latitude, location.longitude)
          : null,
    );
    if (chooseLocationDetail != null) {
      updateLocation(
        location,
        location.copyWith(
          longitude: chooseLocationDetail.location.longitude,
          latitude: chooseLocationDetail.location.latitude,
        ),
      );
    }
  }
}
