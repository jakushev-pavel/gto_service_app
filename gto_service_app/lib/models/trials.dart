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

  int get length {
    int result = 0;

    for (int index = 0; index < groups.length; index++) {
      result += groups[index].group.length;
    }

    return result;
  }

  TrialModel at(int index) {
    int current = 0;
    while (groups[current].group.length <= index) {
      index -= groups[current].group.length;
      current++;
    }

    return groups[current].group[index];
  }
}

class GroupModel {
  bool necessary;
  List<TrialModel> group;

  GroupModel({this.necessary, this.group});

  GroupModel.fromJson(Map<String, dynamic> json) {
    necessary = json['necessary'];
    if (json['group'] != null) {
      group = List<TrialModel>();
      json['group'].forEach((v) {
        group.add(TrialModel.fromJson(v));
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
