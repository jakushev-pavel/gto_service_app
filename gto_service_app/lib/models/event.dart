class Event {
  int id;
  int organizationId;
  String name;
  DateTime startDate;
  DateTime expirationDate;
  String description;
  String status;

  Event({
    this.id,
    this.organizationId,
    this.name,
    this.startDate,
    this.expirationDate,
    this.description,
    this.status,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organizationId'];
    name = json['name'];
    startDate = DateTime.parse(json['startDate']);
    expirationDate = DateTime.parse(json['expirationDate']);
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organizationId'] = this.organizationId;
    data['name'] = this.name;
    data['startDate'] = this.startDate.toUtc();
    data['expirationDate'] = this.expirationDate.toUtc();
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}
