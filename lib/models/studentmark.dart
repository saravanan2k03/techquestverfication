class StudentMark {
  String? techquestId;
  String? teamName;
  String? events;
  String? mark;

  StudentMark({this.techquestId, this.teamName, this.events, this.mark});

  StudentMark.fromJson(Map<String, dynamic> json) {
    techquestId = json['techquest_id'];
    teamName = json['TeamName'];
    events = json['Events'];
    mark = json['Mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['techquest_id'] = techquestId;
    data['TeamName'] = teamName;
    data['Events'] = events;
    data['Mark'] = mark;
    return data;
  }
}
