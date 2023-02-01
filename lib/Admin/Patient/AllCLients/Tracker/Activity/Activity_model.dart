class ActivityModel {
  List<Predefined>? predefined;
  List<Custom>? custom;
  Customized? customized;

  ActivityModel({this.predefined, this.custom, this.customized});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    if (json['predefined'] != null) {
      predefined = [];
      json['predefined'].forEach((v) {
        predefined!.add( Predefined.fromJson(v));
      });
    }
    if (json['custom'] != null) {
      custom = [];
      json['custom'].forEach((v) {
        custom!.add( Custom.fromJson(v));
      });
    }
    customized = json['customized'] != null
        ?  Customized.fromJson(json['customized'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predefined != null) {
      data['predefined'] = this.predefined!.map((v) => v.toJson()).toList();
    }
    if (this.custom != null) {
      data['custom'] = this.custom!.map((v) => v.toJson()).toList();
    }
    if (this.customized != null) {
      data['customized'] = this.customized!.toJson();
    }
    return data;
  }
}

class Custom {
  int? id;
  bool? completed;
  String? name;

  Custom({this.id, this.completed, this.name});

  Custom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    completed = json['completed'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['completed'] = this.completed;
    data['name'] = this.name;
    return data;
  }
}

class Customized {
  String? url;
  String? customer;
  String? module;

  Customized({this.url, this.customer, this.module});

  Customized.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    customer = json['customer'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['customer'] = this.customer;
    data['module'] = this.module;
    return data;
  }
}
class Predefined {
  int? id;
  String? mainModule;
  String? description;
  String? url;
  List<SubModule>? subModule;

  Predefined(
      {this.id, this.mainModule, this.description, this.url, this.subModule});

  Predefined.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainModule = json['mainModule'];
    description = json['description'];
    url = json['url'];
    if (json['sub_module'] != null) {
      subModule = [];
      json['sub_module'].forEach((v) {
        subModule!.add(new SubModule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mainModule'] = this.mainModule;
    data['description'] = this.description;
    data['url'] = this.url;
    if (this.subModule != null) {
      data['sub_module'] = this.subModule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubModule {
  int? id;
  String? subModuleName;
  bool? completed;

  SubModule({this.id, this.subModuleName, this.completed});

  SubModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subModuleName = json['subModuleName'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subModuleName'] = this.subModuleName;
    data['completed'] = this.completed;
    return data;
  }
}