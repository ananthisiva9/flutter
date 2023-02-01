
class MedicineModel{
  MedicineModel({
    this.items,
  });

  List<MedicineModelItem>? items;

  factory MedicineModel.fromJson(List<dynamic>? jsonList) => MedicineModel(
    items: jsonList == null
        ? null
        : List<MedicineModelItem>.from(jsonList.map((x) => MedicineModelItem.fromJson(x))),
  );

  List<dynamic>? toJson() =>
      items == null
          ? null
          : List<dynamic>.from(items!.map((x) => x.toJson()));
}


class MedicineModelItem {
  String? medicationTime;
  List<Medicines>? medicines;

  MedicineModelItem({this.medicationTime, this.medicines});

  MedicineModelItem.fromJson(Map<String, dynamic> json) {
    medicationTime = json['MedicationTime'];
    if (json['Medicines'] != null) {
      medicines = [];
      json['Medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicationTime'] = this.medicationTime;
    if (this.medicines != null) {
      data['Medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  int? id;
  String? name;
  bool? taken;

  Medicines({this.id, this.name, this.taken});

  Medicines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    taken = json['taken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['taken'] = this.taken;
    return data;
  }
}