abstract class BaseModel<T> {
  Map<String, dynamic> toMap();
}

class CommonResponse {
  bool? result;
  String? error;
  dynamic remarks;
  dynamic maxid;
  dynamic status;
  dynamic trailer;
  dynamic yard;

  CommonResponse({
    this.result,
    this.error,
    this.remarks,
    this.maxid,
    this.status,
    this.trailer,
    this.yard,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        result: json["Result"] ?? json["result"],
        error: json["Error"] ?? json["error"],
        remarks: json["remarks"],
        maxid: json["maxid"],
        status: json["status"],
        trailer: json["trailer"],
        yard: json["yard"],
      );

  Map<String, dynamic> toJson() => {
        "Result": result,
        "Error": error,
        "remarks": remarks,
        "maxid": maxid,
        "status": status,
        "trailer": trailer,
        "yard": yard,
      };
}
