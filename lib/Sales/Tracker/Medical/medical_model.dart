class MedicalModel {
  InvestigationData? investigationData;
  List<CustomInvestigation>? customInvestigation;

  MedicalModel({this.investigationData, this.customInvestigation});

  MedicalModel.fromJson(Map<String, dynamic> json) {
    investigationData = json['investigation_data'] != null
        ? new InvestigationData.fromJson(json['investigation_data'])
        : null;
    if (json['custom_investigation'] != null) {
      customInvestigation = [];
      json['custom_investigation'].forEach((v) {
        customInvestigation!.add(new CustomInvestigation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.investigationData != null) {
      data['investigation_data'] = this.investigationData!.toJson();
    }
    if (this.customInvestigation != null) {
      data['custom_investigation'] =
          this.customInvestigation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvestigationData {
  int? id;
  String? criticallityValue;
   String? lastUpdated;
   String? date;
   String? hbValue;
   String? hbNormal;
   String? ictValue;
   String? ictNormal;
   String? urineREValue;
   String? urineRENormal;
   String? urineCSValue;
   String? urineCSNormal;
   String? vdrlValue;
   String? vdrlNormal;
   String? hivValue;
   String? hivNormal;
   String? rbsFirstTrimesterValue;
   String? rbsFirstTrimesterNormal;
   String? ogctSecondTrimesterValue;
   String? ogctSecondTrimesterNormal;
   String? ogttSecondTrimesterValue;
   String? ogttSecondTrimesterNormal;
   String? hcvValue;
   String? hcvNormal;
   String? creatineValue;
   String? creatineNormal;
   String? doubleMarkerValue;
   String? doubleMarkerNormal;
   String? tftValue;
   String? tftNormal;
   String? tftDescription;
   String? othersValue;
   String? othersNormal;
   String? othersDescription;
   String? scan;
   String? scanDescription;
   int? customer;
  int? sales;
  int? criticallity;

  InvestigationData(
      {this.id,
      this.criticallityValue,
      this.lastUpdated,
      this.date,
      this.hbValue,
      this.hbNormal,
      this.ictValue,
      this.ictNormal,
      this.urineREValue,
      this.urineRENormal,
      this.urineCSValue,
      this.urineCSNormal,
      this.vdrlValue,
      this.vdrlNormal,
      this.hivValue,
      this.hivNormal,
      this.rbsFirstTrimesterValue,
      this.rbsFirstTrimesterNormal,
      this.ogctSecondTrimesterValue,
      this.ogctSecondTrimesterNormal,
      this.ogttSecondTrimesterValue,
      this.ogttSecondTrimesterNormal,
      this.hcvValue,
      this.hcvNormal,
      this.creatineValue,
      this.creatineNormal,
      this.doubleMarkerValue,
      this.doubleMarkerNormal,
      this.tftValue,
      this.tftNormal,
      this.tftDescription,
      this.othersValue,
      this.othersNormal,
      this.othersDescription,
      this.scan,
      this.scanDescription,
      this.customer,
      this.sales,
      this.criticallity});

  InvestigationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criticallityValue = json['criticallity_value'];
    lastUpdated = json['lastUpdated'];
    date = json['date'];
    hbValue = json['hb_value'];
    hbNormal = json['hb_normal'];
    ictValue = json['ict_value'];
    ictNormal = json['ict_normal'];
    urineREValue = json['urineRE_value'];
    urineRENormal = json['urineRE_normal'];
    urineCSValue = json['urineCS_value'];
    urineCSNormal = json['urineCS_normal'];
    vdrlValue = json['vdrl_value'];
    vdrlNormal = json['vdrl_normal'];
    hivValue = json['hiv_value'];
    hivNormal = json['hiv_normal'];
    rbsFirstTrimesterValue = json['rbs_first_trimester_value'];
    rbsFirstTrimesterNormal = json['rbs_first_trimester_normal'];
    ogctSecondTrimesterValue = json['ogct_second_trimester_value'];
    ogctSecondTrimesterNormal = json['ogct_second_trimester_normal'];
    ogttSecondTrimesterValue = json['ogtt_second_trimester_value'];
    ogttSecondTrimesterNormal = json['ogtt_second_trimester_normal'];
    hcvValue = json['hcv_value'];
    hcvNormal = json['hcv_normal'];
    creatineValue = json['creatine_value'];
    creatineNormal = json['creatine_normal'];
    doubleMarkerValue = json['double_marker_value'];
    doubleMarkerNormal = json['double_marker_normal'];
    tftValue = json['tft_value'];
    tftNormal = json['tft_normal'];
    tftDescription = json['tft_description'];
    othersValue = json['others_value'];
    othersNormal = json['others_normal'];
    othersDescription = json['others_description'];
    scan = json['scan'];
    scanDescription = json['scanDescription'];
    customer = json['customer'];
    sales = json['sales'];
    criticallity = json['criticallity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criticallity_value'] = this.criticallityValue;
    data['lastUpdated'] = this.lastUpdated;
    data['date'] = this.date;
    data['hb_value'] = this.hbValue;
    data['hb_normal'] = this.hbNormal;
    data['ict_value'] = this.ictValue;
    data['ict_normal'] = this.ictNormal;
    data['urineRE_value'] = this.urineREValue;
    data['urineRE_normal'] = this.urineRENormal;
    data['urineCS_value'] = this.urineCSValue;
    data['urineCS_normal'] = this.urineCSNormal;
    data['vdrl_value'] = this.vdrlValue;
    data['vdrl_normal'] = this.vdrlNormal;
    data['hiv_value'] = this.hivValue;
    data['hiv_normal'] = this.hivNormal;
    data['rbs_first_trimester_value'] = this.rbsFirstTrimesterValue;
    data['rbs_first_trimester_normal'] = this.rbsFirstTrimesterNormal;
    data['ogct_second_trimester_value'] = this.ogctSecondTrimesterValue;
    data['ogct_second_trimester_normal'] = this.ogctSecondTrimesterNormal;
    data['ogtt_second_trimester_value'] = this.ogttSecondTrimesterValue;
    data['ogtt_second_trimester_normal'] = this.ogttSecondTrimesterNormal;
    data['hcv_value'] = this.hcvValue;
    data['hcv_normal'] = this.hcvNormal;
    data['creatine_value'] = this.creatineValue;
    data['creatine_normal'] = this.creatineNormal;
    data['double_marker_value'] = this.doubleMarkerValue;
    data['double_marker_normal'] = this.doubleMarkerNormal;
    data['tft_value'] = this.tftValue;
    data['tft_normal'] = this.tftNormal;
    data['tft_description'] = this.tftDescription;
    data['others_value'] = this.othersValue;
    data['others_normal'] = this.othersNormal;
    data['others_description'] = this.othersDescription;
    data['scan'] = this.scan;
    data['scanDescription'] = this.scanDescription;
    data['customer'] = this.customer;
    data['sales'] = this.sales;
    data['criticallity'] = this.criticallity;
    return data;
  }
}

class CustomInvestigation {
  int? id;
  String? date;
  String? name;
  String? value;
  String? normalRange;
  int? customer;
  int? sales;

  CustomInvestigation(
      {this.id,
      this.date,
      this.name,
      this.value,
      this.normalRange,
      this.customer,
      this.sales});

  CustomInvestigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    value = json['value'];
    normalRange = json['normal_range'];
    customer = json['customer'];
    sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['value'] = this.value;
    data['normal_range'] = this.normalRange;
    data['customer'] = this.customer;
    data['sales'] = this.sales;
    return data;
  }
}