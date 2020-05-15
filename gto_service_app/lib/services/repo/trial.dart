import 'package:get_it/get_it.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/routes.dart';
import 'package:gtoserviceapp/services/repo/referee.dart';

class Trial {
  int trialInEventId;
  int id;
  int resultOfTrialInEventId;
  String name;
  bool trialIsTypeTime;
  int tableId;
  int eventId;
  int sportObjectId;
  String sportObjectName;
  String sportObjectAddress;
  String sportObjectDescription;
  List<Referee> referees;

  Trial(
      {this.trialInEventId,
      this.id,
      this.resultOfTrialInEventId,
      this.name,
      this.trialIsTypeTime,
      this.tableId,
      this.eventId,
      this.sportObjectId,
      this.sportObjectName,
      this.sportObjectAddress,
      this.sportObjectDescription,
      this.referees});

  Trial.fromJson(Map<String, dynamic> json) {
    trialInEventId = json['trialInEventId'];
    id = json['trialId'];
    resultOfTrialInEventId = json['resultOfTrialInEventId'];
    name = json['trialName'];
    trialIsTypeTime = json['trialIsTypeTime'];
    tableId = json['tableId'];
    eventId = json['eventId'];
    sportObjectId = json['sportObjectId'];
    sportObjectName = json['sportObjectName'];
    sportObjectAddress = json['sportObjectAddress'];
    sportObjectDescription = json['sportObjectDescription'];
    if (json['referies'] != null) {
      referees = new List<Referee>();
      json['referies'].forEach((v) {
        referees.add(Referee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trialInEventId'] = this.trialInEventId;
    data['trialId'] = this.id;
    data['resultOfTrialInEventId'] = this.resultOfTrialInEventId;
    data['trialName'] = this.name;
    data['trialIsTypeTime'] = this.trialIsTypeTime;
    data['tableId'] = this.tableId;
    data['eventId'] = this.eventId;
    data['sportObjectId'] = this.sportObjectId;
    data['sportObjectName'] = this.sportObjectName;
    data['sportObjectAddress'] = this.sportObjectAddress;
    data['sportObjectDescription'] = this.sportObjectDescription;
    if (this.referees != null) {
      data['referies'] = this.referees.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrialRepo {
  static TrialRepo get I {
    return GetIt.I<TrialRepo>();
  }

  Future<List<Trial>> getFromEvent(int eventId) async {
    List<dynamic> json = await API.I.get(
      Routes.EventTrials.withArgs(eventId: eventId.toString()),
      auth: true,
    );
    return json.map((json) => Trial.fromJson(json)).toList();
  }
}
