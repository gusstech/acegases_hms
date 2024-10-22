class LoginModel {
  String? driverId;
  String? name;
  dynamic email;
  String? mobile;
  bool? result;
  String? error;
  bool? critUpdate;
  String? version;
  String? imei;
  bool? ptIstatus;
  dynamic latestapk;
  String? driverLicenceNo;
  String? driverDob;
  String? driverDateOfJoining;
  String? gdlExpiryDate;
  bool? gdlResult;
  String? gdlError;
  bool? licenceResult;
  String? licenceError;
  bool? passPortResult;
  String? passPortError;

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
    this.gdlResult,
    this.gdlError,
    this.licenceResult,
    this.licenceError,
    this.passPortResult,
    this.passPortError,
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
        gdlResult: json["GDLResult"],
        gdlError: json["GDLError"],
        licenceResult: json["LicenceResult"],
        licenceError: json["LicenceError"],
        passPortResult: json["PassPortResult"],
        passPortError: json["PassPortError"],
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
        "GDLResult": gdlResult,
        "GDLError": gdlError,
        "LicenceResult": licenceResult,
        "LicenceError": licenceError,
        "PassPortResult": passPortResult,
        "PassPortError": passPortError,
      };
}
