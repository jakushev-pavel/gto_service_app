import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class EventRepo {
  static EventRepo get I {
    return GetIt.I<EventRepo>();
  }

  Future add(String orgId, Event event) async {
    return API.I.post(
      Routes.Events.withArgs(orgId: orgId),
      args: event.toJson(),
      auth: true,
    );
  }

  Future<List<Event>> getAll(String orgId) async {
    List<dynamic> json = await API.I.get(Routes.Events.withArgs(orgId: orgId));
    return json.map((eventJson) => Event.fromJson(eventJson)).toList();
  }

  Future<Event> get(String orgId, int id) async {
    var json = await API.I.get(
      Routes.Event.withArgs(orgId: orgId, eventId: id.toString()),
    );
    return Event.fromJson(json);
  }

  Future update(String orgId, Event event) async {
    return API.I.put(
      Routes.Event.withArgs(orgId: orgId, eventId: event.id.toString()),
      event.toJson(),
      auth: true,
    );
  }

  Future delete(String orgId, int id) async {
    return API.I.delete(Routes.Event.withArgs(
      orgId: orgId,
      eventId: id.toString(),
    ));
  }
}
