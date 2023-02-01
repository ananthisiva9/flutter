class AddMedicinemodel {
  String? name;
  String? medicationTime;
  String? date;

  AddMedicinemodel({this.name, this.medicationTime, this.date});

  AddMedicinemodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    medicationTime = json['medicationTime'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['medicationTime'] = this.medicationTime;
    data['date'] = this.date;
    return data;
  }
}