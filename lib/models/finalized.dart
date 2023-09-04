class Finalized {
  String? id;
  String? techquestId;
  String? teamName;
  String? members;
  String? events;
  String? participate;
  String? mark;

  Finalized(
      {this.id,
      this.techquestId,
      this.teamName,
      this.members,
      this.events,
      this.participate,
      this.mark});

  Finalized.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techquestId = json['techquest_id'];
    teamName = json['TeamName'];
    members =
        json['members'].toString().replaceAll('[', '').replaceAll(']', '');
    events = json['Events'];
    participate = json['Participate'];
    mark = json['Mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['techquest_id'] = techquestId;
    data['TeamName'] = teamName;
    data['members'] = members;
    data['Events'] = events;
    data['Participate'] = participate;
    data['Mark'] = mark;
    return data;
  }
}
