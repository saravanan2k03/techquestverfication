// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class StudentDetails {
  String? techquestId;
  String? teamName;
  String? teamLeader;
  String? memberone;
  String? memberTwo;
  String? email;
  String? mobileNo;
  String? knowlegdeBowl;
  String? quizardry;
  String? techVein;
  String? designUp;
  String? codeLog;
  String? screenShot;
  String? collegeName;
  String? verification;

  StudentDetails(
      {this.techquestId,
      this.teamName,
      this.teamLeader,
      this.memberone,
      this.memberTwo,
      this.email,
      this.mobileNo,
      this.knowlegdeBowl,
      this.quizardry,
      this.techVein,
      this.designUp,
      this.codeLog,
      this.screenShot,
      this.collegeName,
      this.verification});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    techquestId = json['techquest_id'];
    teamName = json['TeamName'];
    teamLeader = json['TeamLeader'];
    memberone = json['Memberone'];
    memberTwo = json['MemberTwo'];
    email = json['Email'];
    mobileNo = json['Mobile_No'];
    knowlegdeBowl = json['Knowlegde_Bowl'];
    quizardry = json['Quizardry'];
    techVein = json['Tech_vein'];
    designUp = json['Design_up'];
    codeLog = json['CodeLog'];
    screenShot = json['ScreenShot'];
    collegeName = json['CollegeName'];
    verification = json['verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['techquest_id'] = techquestId;
    data['TeamName'] = teamName;
    data['TeamLeader'] = teamLeader;
    data['Memberone'] = memberone;
    data['MemberTwo'] = memberTwo;
    data['Email'] = email;
    data['Mobile_No'] = mobileNo;
    data['Knowlegde_Bowl'] = knowlegdeBowl;
    data['Quizardry'] = quizardry;
    data['Tech_vein'] = techVein;
    data['Design_up'] = designUp;
    data['CodeLog'] = codeLog;
    data['ScreenShot'] = screenShot;
    data['CollegeName'] = collegeName;
    data['verification'] = verification;
    return data;
  }
}
