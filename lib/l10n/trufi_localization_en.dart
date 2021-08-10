
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'trufi_localization.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for English (`en`).
class TrufiLocalizationEn extends TrufiLocalization {
  TrufiLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get aboutContent => 'We are a Bolivian and international team of people that love and support public transport. We have developed this app to make it easy for people to use the transport system in Cochabamba and the surrounding area.';

  @override
  String get aboutLicenses => 'Licenses';

  @override
  String get aboutOpenSource => 'This app is released as open source on GitHub. Feel free to contribute or bring it to your own city.';

  @override
  String get alertLocationServicesDeniedMessage => 'Please make sure your device has GPS and the Location settings are activated.';

  @override
  String get alertLocationServicesDeniedTitle => 'No location';

  @override
  String get appReviewDialogButtonAccept => 'Write review';

  @override
  String get appReviewDialogButtonDecline => 'Not now';

  @override
  String get appReviewDialogContent => 'Support us with a review on the Google Play Store.';

  @override
  String get appReviewDialogTitle => 'Enjoying Trufi?';

  @override
  String get bikeRentalBikeStation => 'Bike station';

  @override
  String get bikeRentalFetchRentalBike => 'Fetch a rental bike:';

  @override
  String get bikeRentalNetworkFreeFloating => 'Destination is not a designated drop-off area. Rental cannot be completed here. Please check terms & conditions for additional fees.';

  @override
  String get carParkCloseCapacityMessage => 'This car park is close to capacity. Please allow additional time for you journey.';

  @override
  String get carParkExcludeFull => 'Exclude full car parks';

  @override
  String get chooseLocationPageSubtitle => 'Pan & zoom map under pin';

  @override
  String get chooseLocationPageTitle => 'Choose a point';

  @override
  String get commonArrival => 'Arrival';

  @override
  String get commonBikesAvailable => 'bikes at the station';

  @override
  String get commonCall => 'Call';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonCitybikes => 'Citybikes';

  @override
  String get commonConfirmLocation => 'Confirm location';

  @override
  String get commonCustomPlaces => 'Custom places';

  @override
  String get commonDeparture => 'Departure';

  @override
  String get commonDestination => 'Destination';

  @override
  String get commonDetails => 'Details';

  @override
  String get commonError => 'Error';

  @override
  String get commonFailLoading => 'Failed to load data';

  @override
  String get commonFavoritePlaces => 'Favorite places';

  @override
  String get commonFromStation => 'from station';

  @override
  String get commonFromStop => 'from stop';

  @override
  String get commonGoOffline => 'Go offline';

  @override
  String get commonGoOnline => 'Go online';

  @override
  String get commonItineraryNoTransitLegs => 'Leave when it suits you';

  @override
  String get commonLeavesAt => 'Leaves at';

  @override
  String get commonLeavingNow => 'Leaving now';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonMapSettings => 'Map Settings';

  @override
  String get commonMoreInformartion => 'More informartion';

  @override
  String get commonNoInternet => 'No internet connection.';

  @override
  String get commonNow => 'Now';

  @override
  String get commonOK => 'OK';

  @override
  String get commonOnDemandTaxi => 'Book a trip';

  @override
  String get commonOrigin => 'Origin';

  @override
  String get commonPlatform => 'Platform';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSettings => 'Settings';

  @override
  String get commonShowMap => 'Show on map';

  @override
  String get commonTomorrow => 'Tomorrow';

  @override
  String get commonTrack => 'Track';

  @override
  String get commonUnknownError => 'Unknown error';

  @override
  String get commonUnkownPlace => 'Unkown place';

  @override
  String get commonWait => 'Wait';

  @override
  String get commonWalk => 'Walk';

  @override
  String get copyrightsPriceProvider => 'Fare information provided by Nahverkehrsgesellschaft Baden-Württemberg mbH (NVBW). No liability for the correctness of the information.';

  @override
  String defaultLocationAdd(Object defaultLocation) {
    return 'Add ${defaultLocation}';
  }

  @override
  String get defaultLocationHome => 'Home';

  @override
  String get defaultLocationWork => 'Work';

  @override
  String departureBikeStation(Object departureStop, Object departureTime) {
    return 'Departure at ${departureTime} from ${departureStop} bike station';
  }

  @override
  String description(Object cityName) {
    return 'The best way to travel with trufis, micros and buses through ${cityName}.';
  }

  @override
  String get donate => 'Donate';

  @override
  String get errorAmbiguousDestination => 'The trip planner is unsure of the location you want to go to. Please select from the following options, or be more specific.';

  @override
  String get errorAmbiguousOrigin => 'The trip planner is unsure of the location you want to start from. Please select from the following options, or be more specific.';

  @override
  String get errorAmbiguousOriginDestination => 'Both origin and destination are ambiguous. Please select from the following options, or be more specific.';

  @override
  String get errorCancelledByUser => 'Canceled by user';

  @override
  String get errorEmailFeedback => 'Could not open mail feedback app, the URL or email is incorrect';

  @override
  String get errorNoBarrierFree => 'Both origin and destination are not wheelchair accessible';

  @override
  String get errorNoTransitTimes => 'No transit times available. The date may be past or too far in the future or there may not be transit service for your trip at the time you chose.';

  @override
  String get errorOutOfBoundary => 'Trip is not possible. You might be trying to plan a trip outside the map data boundary.';

  @override
  String get errorPathNotFound => 'Trip is not possible. Your start or end point might not be safely accessible (for instance, you might be starting on a residential street connected only to a highway).';

  @override
  String get errorServerCanNotHandleRequest => 'The request has errors that the server is not willing or able to process.';

  @override
  String get errorServerTimeout => 'The trip planner is taking way too long to process your request. Please try again later.';

  @override
  String get errorServerUnavailable => 'We\'re sorry. The trip planner is temporarily unavailable. Please try again later.';

  @override
  String get errorTrivialDistance => 'Origin is within a trivial distance of the destination.';

  @override
  String get errorUnknownDestination => 'Destination is unknown. Can you be a bit more descriptive?';

  @override
  String get errorUnknownOrigin => 'Origin is unknown. Can you be a bit more descriptive?';

  @override
  String get errorUnknownOriginDestination => 'Both origin and destination are unknown. Can you be a bit more descriptive?';

  @override
  String get feedbackContent => 'Do you have suggestions for our app or found some errors in the data? We would love to hear from you! Please make sure to add your email address or telephone, so we can respond to you.';

  @override
  String get feedbackTitle => 'Please e-mail us';

  @override
  String get fetchMoreItinerariesEarlierDepartures => 'Earlier departures';

  @override
  String get fetchMoreItinerariesLaterDeparturesTitle => 'Later departures';

  @override
  String get followOnFacebook => 'Follow us on Facebook';

  @override
  String get followOnInstagram => 'Follow us on Instagram';

  @override
  String get followOnTwitter => 'Follow us on Twitter';

  @override
  String get infoMessageDestinationOutsideService => 'No route suggestions were found because the destination is outside the service area.';

  @override
  String get infoMessageNoRouteMsg => 'Unfortunately, no route suggestions were found.';

  @override
  String get infoMessageNoRouteMsgWithChanges => 'Unfortunately, no route suggestions were found. Please check your search settings or try changing the origin or destination.';

  @override
  String get infoMessageNoRouteOriginNearDestination => 'No route suggestions were found because the origin and destination are the same.';

  @override
  String get infoMessageNoRouteOriginSameAsDestination => 'No route suggestions were found because the origin and destination are very close to each other.';

  @override
  String get infoMessageNoRouteShowingAlternativeOptions => 'No route suggestions were found with the your settings. However, we found the following route options:';

  @override
  String get infoMessageOnlyCyclingRoutes => 'Your search returned only cycling routes.';

  @override
  String get infoMessageOnlyWalkingCyclingRoutes => 'Your search returned only walking and cycling routes.';

  @override
  String get infoMessageOnlyWalkingRoutes => 'Your search returned only walking routes.';

  @override
  String get infoMessageOriginOutsideService => 'No route suggestions were found because the origin is outside the service area.';

  @override
  String get infoMessageUseNationalServicePrefix => 'We recommend you try the national journey planner,';

  @override
  String instructionDistanceKm(Object value) {
    return '${value} km';
  }

  @override
  String instructionDistanceMeters(Object value) {
    return '${value} m';
  }

  @override
  String instructionDurationHours(Object value) {
    return '${value} h';
  }

  @override
  String instructionDurationMinutes(Object value) {
    return '${value} min';
  }

  @override
  String instructionJunction(Object street1, Object street2) {
    return '${street1} and ${street2}';
  }

  @override
  String instructionRide(Object vehicle, Object distance, Object duration, Object location) {
    return 'Ride ${vehicle} for ${duration} (${distance}) to\n${location}';
  }

  @override
  String get instructionVehicleBike => 'Bike';

  @override
  String get instructionVehicleBus => 'Bus';

  @override
  String get instructionVehicleCar => 'Car';

  @override
  String get instructionVehicleCarpool => 'Carpool';

  @override
  String get instructionVehicleCommuterTrain => 'Commuter train';

  @override
  String get instructionVehicleGondola => 'Gondola';

  @override
  String get instructionVehicleLightRail => 'Light Rail Train';

  @override
  String get instructionVehicleMetro => 'Metro';

  @override
  String get instructionVehicleMicro => 'Micro';

  @override
  String get instructionVehicleMinibus => 'Minibus';

  @override
  String get instructionVehicleOnCar => 'Drive';

  @override
  String get instructionVehicleSharing => 'Sharing';

  @override
  String get instructionVehicleSharingCarSharing => 'Car sharing';

  @override
  String get instructionVehicleSharingRegioRad => 'RegioRad';

  @override
  String get instructionVehicleSharingTaxi => 'Taxi';

  @override
  String get instructionVehicleTaxi => 'Taxi';

  @override
  String get instructionVehicleTrufi => 'Trufi';

  @override
  String instructionWalk(Object distance, Object duration, Object location) {
    return 'Walk ${duration} (${distance}) to\n${location}';
  }

  @override
  String get itineraryBuyTicket => 'Buy tickets';

  @override
  String get itineraryMissingPrice => 'No price information';

  @override
  String get itineraryPriceOnlyPublicTransport => 'Price only valid for public transport part of the journey.';

  @override
  String get itinerarySummaryBikeAndPublicRailSubwayTitle => 'Take your bike with you on the train or to metro';

  @override
  String get itinerarySummaryBikeParkTitle => 'Leave your bike at a Park & Ride';

  @override
  String get itineraryTicketsTitle => 'Required tickets';

  @override
  String get itineraryTicketTitle => 'Required ticket';

  @override
  String get mapTypeLabel => 'Map Type';

  @override
  String get mapTypeSatelliteCaption => 'Satellite';

  @override
  String get mapTypeStreetsCaption => 'Streets';

  @override
  String get mapTypeTerrainCaption => 'Terrain';

  @override
  String get menuAbout => 'About';

  @override
  String get menuAppReview => 'Rate the app';

  @override
  String get menuConnections => 'Show routes';

  @override
  String get menuFeedback => 'Send Feedback';

  @override
  String get menuOnline => 'Online';

  @override
  String get menuShareApp => 'Share the app';

  @override
  String get menuTeam => 'Team';

  @override
  String get menuYourPlaces => 'Your places';

  @override
  String get noRouteError => 'Sorry, we could not find a route. What do you want to do?';

  @override
  String get noRouteErrorActionCancel => 'Try another destination';

  @override
  String get noRouteErrorActionReportMissingRoute => 'Report a missing route';

  @override
  String get noRouteErrorActionShowCarRoute => 'Show route by car';

  @override
  String get readOurBlog => 'Read our blog';

  @override
  String get savedPlacesEnterNameTitle => 'Enter name';

  @override
  String get savedPlacesRemoveLabel => 'Remove place';

  @override
  String get savedPlacesSelectIconTitle => 'Select symbol';

  @override
  String get savedPlacesSetIconLabel => 'Change symbol';

  @override
  String get savedPlacesSetNameLabel => 'Edit name';

  @override
  String get savedPlacesSetPositionLabel => 'Edit position';

  @override
  String get searchFailLoadingPlan => 'Failed to load plan.';

  @override
  String get searchHintDestination => 'Choose destination';

  @override
  String get searchHintOrigin => 'Choose starting point';

  @override
  String get searchItemChooseOnMap => 'Choose on map';

  @override
  String get searchItemNoResults => 'No results';

  @override
  String get searchItemYourLocation => 'Your location';

  @override
  String get searchMapMarker => 'Map Marker';

  @override
  String get searchPleaseSelectDestination => 'Select destination';

  @override
  String get searchPleaseSelectOrigin => 'Select origin';

  @override
  String get searchTitleFavorites => 'Favorites';

  @override
  String get searchTitlePlaces => 'Places';

  @override
  String get searchTitleRecent => 'Recent';

  @override
  String get searchTitleResults => 'Search Results';

  @override
  String get settingPanelAccessibility => 'Accessibility';

  @override
  String get settingPanelAvoidTransfers => 'Avoid transfers';

  @override
  String get settingPanelAvoidWalking => 'Avoid walking';

  @override
  String get settingPanelBikingSpeed => 'Biking speed';

  @override
  String get settingPanelMyModesTransport => 'My modes of transport';

  @override
  String get settingPanelMyModesTransportBike => 'Bike';

  @override
  String get settingPanelMyModesTransportBikeRide => 'Bike & Ride';

  @override
  String get settingPanelMyModesTransportParkRide => 'Park & Ride';

  @override
  String get settingPanelTransportModes => 'Transport modes';

  @override
  String get settingPanelWalkingSpeed => 'Walking speed';

  @override
  String get settingPanelWheelchair => 'Wheelchair';

  @override
  String shareAppText(Object url, Object appTitle, Object cityName) {
    return 'Download ${appTitle}, the public transport app for ${cityName}, at ${url}';
  }

  @override
  String tagline(Object city) {
    return 'Public transportation in ${city}';
  }

  @override
  String get teamContent => 'We are an international team called Trufi Association that has created this app with the help of many volunteers! Do you want to improve the Trufi App and be part of our team? Please contact us via:';

  @override
  String teamSectionRepresentatives(Object representatives) {
    return 'Representatives: ${representatives}';
  }

  @override
  String teamSectionRoutes(Object osmContributors, Object routeContributors) {
    return 'Routes: ${routeContributors} and all users that uploaded routes to OpenStreetMap, such as ${osmContributors}.\nContact us if you want to join the OpenStreetMap community!';
  }

  @override
  String teamSectionTeam(Object teamMembers) {
    return 'Team: ${teamMembers}';
  }

  @override
  String teamSectionTranslations(Object translators) {
    return 'Translations: ${translators}';
  }

  @override
  String get title => 'Trufi App';

  @override
  String get typeSpeedAverage => 'Normal';

  @override
  String get typeSpeedCalm => 'Calm';

  @override
  String get typeSpeedFast => 'Fast';

  @override
  String get typeSpeedPrompt => 'Prompt';

  @override
  String get typeSpeedSlow => 'Slow';

  @override
  String version(Object version) {
    return 'Version ${version}';
  }
}
