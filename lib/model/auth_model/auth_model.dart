import 'package:acegases_hms/model/base_response_model.dart';

class LoginModel {
  String? driverId;
  String? name;
  dynamic email;
  String? mobile;
  bool? result;
  dynamic error;
  bool? critUpdate;
  String? version;
  String? imei;
  bool? ptIstatus;
  String? latestapk;
  String? driverLicenceNo;
  String? driverDob;
  String? driverDateOfJoining;
  String? gdlExpiryDate;

  LoginModel({
    this.driverId,
    this.name,
    this.email,
    this.mobile,
    this.result,
    this.error,
    this.critUpdate,
    this.version,
    this.imei,
    this.ptIstatus,
    this.latestapk,
    this.driverLicenceNo,
    this.driverDob,
    this.driverDateOfJoining,
    this.gdlExpiryDate,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        driverId: json["DriverID"],
        name: json["Name"],
        email: json["Email"],
        mobile: json["Mobile"],
        result: json["Result"],
        error: json["Error"],
        critUpdate: json["CritUpdate"],
        version: json["Version"],
        imei: json["IMEI"],
        ptIstatus: json["PTIstatus"],
        latestapk: json["latestapk"],
        driverLicenceNo: json["Driver_Licence_No"],
        driverDob: json["Driver_DOB"],
        driverDateOfJoining: json["Driver_Date_Of_Joining"],
        gdlExpiryDate: json["GDLExpiryDate"],
      );

  Map<String, dynamic> toJson() => {
        "DriverID": driverId,
        "Name": name,
        "Email": email,
        "Mobile": mobile,
        "Result": result,
        "Error": error,
        "CritUpdate": critUpdate,
        "Version": version,
        "IMEI": imei,
        "PTIstatus": ptIstatus,
        "latestapk": latestapk,
        "Driver_Licence_No": driverLicenceNo,
        "Driver_DOB": driverDob,
        "Driver_Date_Of_Joining": driverDateOfJoining,
        "GDLExpiryDate": gdlExpiryDate,
      };

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
