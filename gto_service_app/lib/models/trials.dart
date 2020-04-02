class TrialsModel {
  List<GroupModel> groups;
  String ageCategory;

  TrialsModel({this.groups, this.ageCategory});

  TrialsModel.fromJSON(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = new List<GroupModel>();
      json['groups'].forEach((v) {
        groups.add(GroupModel.fromJson(v));
      });
    }
    ageCategory = json['ageCategory'];
  }
}

class GroupModel {
  bool necessary;
  List<TrialModel> trials;

  GroupModel({this.necessary, this.trials});

  GroupModel.fromJson(Map<String, dynamic> json) {
    necessary = json['necessary'];
    if (json['group'] != null) {
      trials = List<TrialModel>();
      json['group'].forEach((v) {
        trials.add(TrialModel.fromJson(v));
      });
    }
  }
}

class TrialModel {
  String trialName;
  int trialId;
  String resultForBronze;
  String resultForSilver;
  String resultForGold;
  bool typeTime;

  TrialModel({
    this.trialName,
    this.trialId,
    this.resultForBronze,
    this.resultForSilver,
    this.resultForGold,
    this.typeTime,
  });

  TrialModel.fromJson(Map<String, dynamic> json) {
    trialName = json['trialName'];
    trialId = json['trialId'];
    resultForBronze = json['resultForBronze'];
    resultForSilver = json['resultForSilver'];
    resultForGold = json['resultForGold'];
    typeTime = json['typeTime'];
  }
}
