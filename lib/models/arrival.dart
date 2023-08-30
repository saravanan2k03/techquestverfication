class arrival {
  String? id;
  String? techquestId;
  String? teamName;
  String? member;
  String? events;
  String? participate;
  String? mark;

  arrival(
      {this.id,
      this.techquestId,
      this.teamName,
      this.member,
      this.events,
      this.participate,
      this.mark});

  arrival.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techquestId = json['techquest_id'];
    teamName = json['TeamName'];
    member = json['Member'];
    events = json['Events'];
    participate = json['Participate'];
    mark = json['Mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['techquest_id'] = techquestId;
    data['TeamName'] = teamName;
    data['Member'] = member;
    data['Events'] = events;
    data['Participate'] = participate;
    data['Mark'] = mark;
    return data;
  }
}
