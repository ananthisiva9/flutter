class CompletedModel{
  CompletedModel({
    this.items,
  });

  List<CompletedItem>? items;

  factory CompletedModel.fromJson(List<dynamic>? jsonList) => CompletedModel(
    items: jsonList == null
        ? null
        : List<CompletedItem>.from(jsonList.map((x) => CompletedItem.fromJson(x))),
  );

  List<dynamic>? toJson() =>
      items == null
          ? null
          : List<dynamic>.from(items!.map((x) => x.toJson()));
}
class CompletedItem {
  int? id;
  String? doctor;
  int? experience;
  String? qualification;
  String? time;
  String? date;
  String? doctor_profile_pic;

  CompletedItem(
      {this.doctor, this.experience, this.qualification, this.time, this.date,this.doctor_profile_pic});

  CompletedItem.fromJson(Map<String, dynamic> json) {
    id = json ['id'];
    doctor = json['doctor'];
    experience = json['experience'];
    qualification = json['qualification'];
    time = json['time'];
    date = json['date'];
    doctor_profile_pic = json['doctor_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data ['id'] = this.id;
    data['doctor'] = this.doctor;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['time'] = this.time;
    data['date'] = this.date;
    data['doctor_profile_pic'] = this.doctor_profile_pic;
    return data;
  }
}