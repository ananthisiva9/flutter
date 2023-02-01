class DisplayModel {
  int? doctorId;
  int? approvalRequests;
  int? todaysAppointmentsCount;
  int? totalClients;
  int? clientsThisMonth;
  List<GraphData>? graphData;
  List<LatestConsultation>? latestConsultation;
  String? profile_pic;

  DisplayModel(
      {this.doctorId,
      this.approvalRequests,
      this.todaysAppointmentsCount,
      this.totalClients,
      this.clientsThisMonth,
      this.graphData,
      this.latestConsultation,
      this.profile_pic});

  DisplayModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    approvalRequests = json['approvalRequests'];
    todaysAppointmentsCount = json['todaysAppointmentsCount'];
    totalClients = json['totalClients'];
    clientsThisMonth = json['clientsThisMonth'];
    profile_pic = json['profile_pic'];
    if (json['graphData'] != null) {
      graphData = [];
      json['graphData'].forEach((v) {
        graphData!.add(new GraphData.fromJson(v));
      });
    }
    if (json['latestConsultation'] != null) {
      latestConsultation = [];
      json['latestConsultation'].forEach((v) {
        latestConsultation!.add(new LatestConsultation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doctorId'] = this.doctorId;
    data['approvalRequests'] = this.approvalRequests;
    data['todaysAppointmentsCount'] = this.todaysAppointmentsCount;
    data['totalClients'] = this.totalClients;
    data['clientsThisMonth'] = this.clientsThisMonth;
    data['profile_pic'] = this.profile_pic;
    if (this.graphData != null) {
      data['graphData'] = this.graphData!.map((v) => v.toJson()).toList();
    }
    if (this.latestConsultation != null) {
      data['latestConsultation'] =
          this.latestConsultation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphData {
  String? month;
  int? appointments;
  int? cancelled;

  GraphData({this.month, this.appointments, this.cancelled});

  GraphData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    appointments = json['appointments'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['month'] = this.month;
    data['appointments'] = this.appointments;
    data['cancelled'] = this.cancelled;
    return data;
  }
}

class LatestConsultation {
  int? id;
  String? firstname;
  String? lastname;
  String? time;
  String? date;
  String? meetingUrl;

  LatestConsultation(
      {this.id,
      this.firstname,
      this.lastname,
      this.time,
      this.date,
      this.meetingUrl});

  LatestConsultation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    time = json['time'];
    date = json['date'];
    meetingUrl = json['meeting_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['time'] = this.time;
    data['date'] = this.date;
    data['meeting_url'] = this.meetingUrl;
    return data;
  }
}

class LoginUserDataModel {
  String? firstname;
  String? lastname;
  String? email;

  LoginUserDataModel({this.firstname, this.lastname, this.email});

  LoginUserDataModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    return data;
  }
}
