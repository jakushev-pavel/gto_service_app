import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';

class Table {
  int tableInEventId;
  int eventId;
  int id;
  String name;

  Table({this.tableInEventId, this.eventId, this.id, this.name});

  Table.fromJson(Map<String, dynamic> json) {
    tableInEventId = json['tableInEventId'];
    eventId = json['eventId'];
    id = json['tableId'];
    name = json['tableName'];
    name = name ?? json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableInEventId'] = this.tableInEventId;
    data['eventId'] = this.eventId;
    data['tableId'] = this.id;
    data['tableName'] = this.name;
    data['name'] = this.name;
    return data;
  }
}

class TableRepo {
  static TableRepo get I {
    return GetIt.I<TableRepo>();
  }

  Future<List<Table>> getAll() async {
    List<dynamic> json = await API.I.get(Routes.Tables.toStr());
    return json.map((json) => Table.fromJson(json)).toList();
  }

  Future<Table> getFromEvent(int eventId) {
    return API.I.get(Routes.EventTableGet.withArgs(eventId: eventId));
  }

  Future setForEvent(int eventId, int tableId) {
    return API.I.post(Routes.EventTableSet.withArgs(
      eventId: eventId,
      tableId: tableId,
    ));
  }
}
