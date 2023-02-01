class SubscriptionModel {
  int? oneMonthPlan;
  int? threeMonthPlan;
  int? pregnancyClass;
  int? fullPregnancyPackage;
  int? activeClients;
  int? disabledClients;

  SubscriptionModel(
      {this.oneMonthPlan,
        this.threeMonthPlan,
        this.pregnancyClass,
        this.fullPregnancyPackage,
        this.activeClients,
        this.disabledClients});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    oneMonthPlan = json['oneMonthPlan'];
    threeMonthPlan = json['threeMonthPlan'];
    pregnancyClass = json['pregnancyClass'];
    fullPregnancyPackage = json['fullPregnancyPackage'];
    activeClients = json['activeClients'];
    disabledClients = json['disabledClients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oneMonthPlan'] = this.oneMonthPlan;
    data['threeMonthPlan'] = this.threeMonthPlan;
    data['pregnancyClass'] = this.pregnancyClass;
    data['fullPregnancyPackage'] = this.fullPregnancyPackage;
    data['activeClients'] = this.activeClients;
    data['disabledClients'] = this.disabledClients;
    return data;
  }
}