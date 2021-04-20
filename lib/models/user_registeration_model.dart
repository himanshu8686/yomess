import 'dart:convert';

UserRegisterationModel userRegisterationModelFromJson(String str) =>
    UserRegisterationModel.fromJson(json.decode(str));

String userRegisterationModelToJson(UserRegisterationModel data) =>
    json.encode(data.toJson());

class UserRegisterationModel {
  UserRegisterationModel({
    this.success,
    this.data,
    this.message,
  });

  final bool success;
  final Data data;
  final String message;

  factory UserRegisterationModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterationModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.name,
    this.email,
    this.countryCode,
    this.mobile,
    this.deviceToken,
    this.apiToken,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.customFields,
    this.hasMedia,
    this.roles,
    this.media,
  });

  final String name;
  final String email;
  final String countryCode;
  final String mobile;
  final String deviceToken;
  final String apiToken;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final List<dynamic> customFields;
  final bool hasMedia;
  final List<Role> roles;
  final List<dynamic> media;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        deviceToken: json["device_token"],
        apiToken: json["api_token"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
        hasMedia: json["has_media"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "device_token": deviceToken,
        "api_token": apiToken,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
        "has_media": hasMedia,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.guardName,
    this.roleDefault,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  final int id;
  final String name;
  final String guardName;
  final int roleDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Pivot pivot;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        roleDefault: json["default"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "default": roleDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  final int modelId;
  final int roleId;
  final String modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
