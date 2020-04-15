import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class EventRepo {
  static get I {
    return GetIt.I<EventRepo>();
  }

  Future<List<Event>> getAll(String orgId) async {
    List<dynamic> json = await API.I.get(Routes.Events.withArgs(orgId: orgId));
    return json.map((eventJson) => Event.fromJson(eventJson)).toList();
  }
}