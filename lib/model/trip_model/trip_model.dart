class TripDataDTO {
  String? tripNo;
  String? sNo;
  String? customer;
  String? tripStatus;
  String? drivingStatus;
  List<TripJob>? jobList;
  List<String>? attendance;
  bool showAllDate;
  TripDataDTO({
    this.tripNo,
    this.sNo,
    this.customer,
    this.tripStatus,
    this.jobList,
    this.attendance,
    this.drivingStatus,
    required this.showAllDate,
  });

  factory TripDataDTO.fromJson(Map<String, dynamic> json) => TripDataDTO(
      tripNo: json["TripNo"],
      sNo: json["SNo"],
      customer: json["Customer"],
      tripStatus: json["TripStatus"],
      drivingStatus: json["DrivingStatus"],
      showAllDate: false);

  Map<String, dynamic> toJson() => {
        "TripNo": tripNo,
        "SNo": sNo,
        "Customer": customer,
        "TripStatus": tripStatus,
      };
}

class TripJob {
  String? source;
  String? tripLoad;
  String? startPoint;
  String? endPoint;
  String? drivingStatus;
  String? customer;
  String? deliveryDate;
  String? doNo;
  String? lastDate;
  String? tanker;
  String? jobNo;
  String? jobStatus;
  String? attendant1;
  String? attendant2;
  String? attendant3;
  bool isChecked;
  TripJob({
    this.source,
    this.tripLoad,
    this.startPoint,
    this.endPoint,
    this.drivingStatus,
    this.doNo,
    this.customer,
    this.deliveryDate,
    this.lastDate,
    this.jobNo,
    this.tanker,
    this.jobStatus,
    this.attendant1,
    this.attendant2,
    this.attendant3,
    required this.isChecked,
  });

  factory TripJob.fromJson(Map<String, dynamic> json) => TripJob(
      source: json["Source"],
      tripLoad: json["TripLoad"],
      startPoint: json["StartPoint"],
      endPoint: json["EndPoint"],
      drivingStatus: json["DrivingStatus"],
      customer: json["Customer"],
      deliveryDate: json["DeliveryDate"],
      lastDate: json["LastDate"],
      jobNo: json["JobNo"],
      tanker: json["Tanker"],
      jobStatus: json["JobStatus"],
      attendant1: json["Attendant1"],
      attendant2: json["Attendant2"],
      attendant3: json["Attendant3"],
      isChecked: false,
      doNo: json["DONo"]);

  Map<String, dynamic> toJson() => {
        "Source": source,
        "TripLoad": tripLoad,
        "StartPoint": startPoint,
        "EndPoint": endPoint,
        "DrivingStatus": drivingStatus,
        "Customer": customer,
        "DeliveryDate": deliveryDate,
        "LastDate": lastDate,
        "JobNo": jobNo,
        "JobStatus": jobStatus,
        "Attendant1": attendant1,
        "Attendant2": attendant2,
        "Attendant3": attendant3,
        "DONo": doNo,
      };
}

class JobDetails {
  String? dropFm;
  String? dropWb;
  String? jobStatus;
  String? remark;

  JobDetails({
    this.dropFm,
    this.dropWb,
    this.jobStatus,
    this.remark,
  });

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
        dropFm: json["DropFM"],
        dropWb: json["DropWB"],
        jobStatus: json["JobStatus"],
        remark: json["Remark"],
      );

  Map<String, dynamic> toJson() => {
        "DropFM": dropFm,
        "DropWB": dropWb,
        "JobStatus": jobStatus,
        "Remark": remark,
      };
}
