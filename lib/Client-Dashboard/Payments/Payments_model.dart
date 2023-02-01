class PaymentsModel{
   PaymentsModel({
    this.items,
  });

  List<PaymentsItem>? items;

  factory PaymentsModel.fromJson(List<dynamic>? jsonList) => PaymentsModel(
        items: jsonList == null
            ? null
            : List<PaymentsItem>.from(jsonList.map((x) => PaymentsItem.fromJson(x))),
      );

  List<dynamic>? toJson() => 
         items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson()));
}


class PaymentsItem {
  int? id;
  String? doctorFirstname;
  String? doctorLastname;
  String? doctorQualification;
  String? doctorExperience;
  int? payment;

  PaymentsItem(
      {this.id,
      this.doctorFirstname,
      this.doctorLastname,
      this.doctorQualification,
      this.doctorExperience,
      this.payment});

  PaymentsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorFirstname = json['doctor_firstname'];
    doctorLastname = json['doctor_lastname'];
    doctorQualification = json['doctor_qualification'];
    doctorExperience = json['doctor_experience'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_firstname'] = this.doctorFirstname;
    data['doctor_lastname'] = this.doctorLastname;
    data['doctor_qualification'] = this.doctorQualification;
    data['doctor_experience'] = this.doctorExperience;
    data['payment'] = this.payment;
    return data;
  }
}