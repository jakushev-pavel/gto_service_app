import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/models/event_state.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class Event {
  int id;
  int organizationId;
  String name;
  DateTime startDate;
  DateTime expirationDate;
  String description;
  EventState state;

  Event({
    this.id,
    this.organizationId,
    this.name,
    this.startDate,
    this.expirationDate,
    this.description,
    this.state,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organizationId'];
    name = json['name'];
    startDate = DateTime.parse(json['startDate']);
    expirationDate = DateTime.parse(json['expirationDate']);
    description = json['description'];
    state = EventStateEx.fromStr(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organizationId'] = this.organizationId;
    data['name'] = this.name;
    data['startDate'] = Utils.dateToJson(this.startDate);
    data['expirationDate'] = Utils.dateToJson(this.expirationDate);
    data['description'] = this.description;
    data['status'] = this.state?.toStr();
    return data;
  }
}

class EventRepo {
  static EventRepo get I {
    return GetIt.I<EventRepo>();
  }

  Future add(int orgId, Event event) async {
    return API.I.post(
      Routes.OrgEvents.withArgs(orgId: orgId),
      args: event.toJson(),
      auth: true,
    );
  }

  Future<List<Event>> getAllForUser() async {
    List<dynamic> json = await API.I.get(Routes.UserEvents.toStr());
    return Utils.map(json, (json) => Event.fromJson(json));
  }

  Future<List<Event>> getAllForSecretary() async {
    List<dynamic> json = await API.I.get(
      Routes.SecretaryEvents.toStr(),
      auth: true,
    );
    return Utils.map(json, (json) => Event.fromJson(json));
  }

  Future<List<Event>> getAllFromOrg(int orgId) async {
    List<dynamic> json =
        await API.I.get(Routes.OrgEvents.withArgs(orgId: orgId));
    return Utils.map(json, (json) => Event.fromJson(json));
  }

  Future<Event> get(int orgId, int eventId) async {
    var json = await API.I.get(
      Routes.OrgEvent.withArgs(orgId: orgId, eventId: eventId),
    );
    return Event.fromJson(json);
  }

  Future update(int orgId, Event event) async {
    return API.I.put(
      Routes.OrgEvent.withArgs(orgId: orgId, eventId: event.id),
      event.toJson(),
      auth: true,
    );
  }

  Future changeStatus(int eventId) {
    return API.I.post(
      Routes.EventChangeStatus.withArgs(eventId: eventId),
      auth: true,
    );
  }

  Future apply(int eventId) {
    return API.I.post(Routes.EventApply.withArgs(eventId: eventId));
  }

  Future unsubscribe(int eventId) {
    return API.I.post(Routes.EventUnsubscribe.withArgs(eventId: eventId));
  }

  Future delete(int orgId, int eventId) async {
    return API.I.delete(Routes.OrgEvent.withArgs(
      orgId: orgId,
      eventId: eventId,
    ));
  }
}
