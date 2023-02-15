class LoginModel {
  LoginModel({
    required this.agent,
    required this.code,
    required this.employeeId,
    required this.entityId,
    required this.entityName,
    required this.expiry,
    required this.name,
    required this.profilePic,
    required this.role,
    required this.roleName,
    required this.token,
    required this.tokenValidation,
    required this.userId,
  });

  int agent;
  String code;
  int employeeId;
  int entityId;
  String entityName;
  String expiry;
  String name;
  String profilePic;
  int role;
  String roleName;
  String token;
  List<TokenValidation> tokenValidation;
  int userId;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    agent: json["agent"],
    code: json["code"],
    employeeId: json["employee_id"],
    entityId: json["entity_id"],
    entityName: json["entity_name"],
    expiry: json["expiry"],
    name: json["name"],
    profilePic: json["profile_pic"],
    role: json["role"],
    roleName: json["role_name"],
    token: json["token"],
    tokenValidation: List<TokenValidation>.from(json["token_validation"].map((x) => TokenValidation.fromJson(x))),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "agent": agent,
    "code": code,
    "employee_id": employeeId,
    "entity_id": entityId,
    "entity_name": entityName,
    "expiry": expiry,
    "name": name,
    "profile_pic": profilePic,
    "role": role,
    "role_name": roleName,
    "token": token,
    "token_validation": List<dynamic>.from(tokenValidation.map((x) => x.toJson())),
    "user_id": userId,
  };
}

class TokenValidation {
  TokenValidation({
    required this.code,
    required this.descriptions,
  });

  int code;
  String descriptions;

  factory TokenValidation.fromJson(Map<String, dynamic> json) => TokenValidation(
    code: json["code"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "descriptions": descriptions,
  };
}
