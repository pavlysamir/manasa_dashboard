class UserData {
  int? id;
  bool? success;
  String? message;
  Data? data;
  dynamic errors;

  UserData({this.id, this.success, this.message, this.data, this.errors});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? mobileNo;
  String? email;
  String? governorate;
  String? district;
  dynamic registrationGrade;
  dynamic generalLawBachelor;
  dynamic barAssociation;
  dynamic registrationNumber;
  String? address;
  String? description;
  String? status;
  List<SpecializationFields>? specializationFields;
  List<AvailableWorks>? availableWorks;
  List<Pictures>? pictures;

  Data(
      {this.userId,
      this.name,
      this.mobileNo,
      this.email,
      this.governorate,
      this.district,
      this.registrationGrade,
      this.generalLawBachelor,
      this.barAssociation,
      this.registrationNumber,
      this.address,
      this.description,
      this.status,
      this.specializationFields,
      this.availableWorks,
      this.pictures});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    governorate = json['governorate'];
    district = json['district'];
    registrationGrade = json['registrationGrade'];
    generalLawBachelor = json['generalLawBachelor'];
    barAssociation = json['barAssociation'];
    registrationNumber = json['registrationNumber'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    if (json['specializationFields'] != null) {
      specializationFields = <SpecializationFields>[];
      json['specializationFields'].forEach((v) {
        specializationFields!.add(new SpecializationFields.fromJson(v));
      });
    }
    if (json['availableWorks'] != null) {
      availableWorks = <AvailableWorks>[];
      json['availableWorks'].forEach((v) {
        availableWorks!.add(new AvailableWorks.fromJson(v));
      });
    }
    if (json['pictures'] != null) {
      pictures = <Pictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(new Pictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['governorate'] = this.governorate;
    data['district'] = this.district;
    data['registrationGrade'] = this.registrationGrade;
    data['generalLawBachelor'] = this.generalLawBachelor;
    data['barAssociation'] = this.barAssociation;
    data['registrationNumber'] = this.registrationNumber;
    data['address'] = this.address;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.specializationFields != null) {
      data['specializationFields'] =
          this.specializationFields!.map((v) => v.toJson()).toList();
    }
    if (this.availableWorks != null) {
      data['availableWorks'] =
          this.availableWorks!.map((v) => v.toJson()).toList();
    }
    if (this.pictures != null) {
      data['pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecializationFields {
  int? specializationFieldId;
  String? name;
  bool? isPrimary;

  SpecializationFields({this.specializationFieldId, this.name, this.isPrimary});

  SpecializationFields.fromJson(Map<String, dynamic> json) {
    specializationFieldId = json['specializationFieldId'];
    name = json['name'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specializationFieldId'] = this.specializationFieldId;
    data['name'] = this.name;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class AvailableWorks {
  int? availabilityWorkId;
  String? name;
  dynamic description;

  AvailableWorks({this.availabilityWorkId, this.name, this.description});

  AvailableWorks.fromJson(Map<String, dynamic> json) {
    availabilityWorkId = json['availabilityWorkId'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availabilityWorkId'] = this.availabilityWorkId;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Pictures {
  int? fileTypetId;
  dynamic fileTypeName;
  String? url;
  String? fileName;
  String? description;

  Pictures(
      {this.fileTypetId,
      this.fileTypeName,
      this.url,
      this.fileName,
      this.description});

  Pictures.fromJson(Map<String, dynamic> json) {
    fileTypetId = json['fileTypetId'];
    fileTypeName = json['fileTypeName'];
    url = json['url'];
    fileName = json['fileName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileTypetId'] = this.fileTypetId;
    data['fileTypeName'] = this.fileTypeName;
    data['url'] = this.url;
    data['fileName'] = this.fileName;
    data['description'] = this.description;
    return data;
  }
}
