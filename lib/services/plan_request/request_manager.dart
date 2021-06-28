import 'package:meta/meta.dart';

import 'package:trufi_core/blocs/payload_data_plan/payload_data_plan_cubit.dart';
import 'package:trufi_core/entities/ad_entity/ad_entity.dart';
import 'package:trufi_core/entities/plan_entity/plan_entity.dart';
import 'package:trufi_core/models/trufi_place.dart';

abstract class RequestManager {
  Future<PlanEntity> fetchAdvancedPlan({
    @required TrufiLocation from,
    @required TrufiLocation to,
    @required String correlationId,
    PayloadDataPlanState advancedOptions,
    String localeName,
  });

  Future<ModesTransportEntity> fetchTransportModePlan({
    @required TrufiLocation from,
    @required TrufiLocation to,
    @required String correlationId,
    PayloadDataPlanState advancedOptions,
    String localeName,
  });

  Future<PlanEntity> fetchCarPlan(
    TrufiLocation from,
    TrufiLocation to,
    String correlationId,
  );

  Future<AdEntity> fetchAd(
    TrufiLocation to,
    String correlationId,
  );
}
