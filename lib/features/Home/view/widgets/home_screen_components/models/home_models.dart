class RequestResponse {
  List<Data>? data;
  String? msg;
  String? state;

  RequestResponse({this.data, this.msg, this.state});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['state'] = state;
    return data;
  }
}

class Data {
  String? oNum;
  String? oId;
  String? oDate;
  String? cId;
  String? cName;
  String? cPhone;
  String? cAddress;
  String? oTotal;
  String? oServiceFee;
  String? oDeliveryFee;
  String? oTax;
  String? oNetAmount;
  String? oStatus;
  String? oFromName;
  String? oFromLatitude;
  String? oFromLongitude;
  String? oToName;
  String? oToLatitude;
  String? oToLongitude;
  String? oDuration;
  String? oDistance;
  String? oDeliveryId;
  String? oAcceptState;
  dynamic? oProblem;
  String? oOwnerId;
  String? oDeliveredState;
  dynamic? oDeliveredPhoto;
  String? ownerUser;
  String? address;
  dynamic photo;
  dynamic percentRate;
  String? ownerPhone;
  String? oAddBy;
  String? addByUser;
  String? addDate;
  String? oUpdateBy;
  String? updateByUser;
  String? updateDate;
  String? ud_fcm_token_id;
  dynamic o_instructions;
  String? delivery_name;

  Data(
      {this.oId,
        this.oNum,
        this.oDate,
        this.cId,
        this.cName,
        this.cPhone,
        this.cAddress,
        this.oTotal,
        this.oServiceFee,
        this.oDeliveryFee,
        this.oTax,
        this.oNetAmount,
        this.oStatus,
        this.oFromName,
        this.oFromLatitude,
        this.oFromLongitude,
        this.oToName,
        this.oToLatitude,
        this.oToLongitude,
        this.oDuration,
        this.oDistance,
        this.oDeliveryId,
        this.oAcceptState,
        this.oProblem,
        this.oOwnerId,
        this.oDeliveredState,
        this.oDeliveredPhoto,
        this.ownerUser,
        this.address,
        this.photo,
        this.percentRate,
        this.ownerPhone,
        this.oAddBy,
        this.addByUser,
        this.addDate,
        this.oUpdateBy,
        this.updateByUser,
        this.updateDate,
        this.ud_fcm_token_id,this.o_instructions,this.delivery_name});

  Data.fromJson(Map<String, dynamic> json) {
    oId = json['o_id'];
    oNum = json['o_num'];
    oDate = json['o_date'];
    cId = json['c_id'];
    cName = json['c_name'];
    cPhone = json['c_phone'];
    cAddress = json['c_address'];
    oTotal = json['o_total'];
    oServiceFee = json['o_service_fee'];
    oDeliveryFee = json['o_delivery_fee'];
    oTax = json['o_tax'];
    oNetAmount = json['o_net_amount'];
    oStatus = json['o_status'];
    oFromName = json['o_from_name'];
    oFromLatitude = json['o_from_latitude'];
    oFromLongitude = json['o_from_longitude'];
    oToName = json['o_to_name'];
    oToLatitude = json['o_to_latitude'];
    oToLongitude = json['o_to_longitude'];
    oDuration = json['o_duration'];
    oDistance = json['o_distance'];
    oDeliveryId = json['o_delivery_id'];
    oAcceptState = json['o_accept_state'];
    oProblem = json['o_problem'];
    oOwnerId = json['o_owner_id'];
    oDeliveredState = json['o_delivered_state'];
    oDeliveredPhoto = json['o_delivered_photo'];
    ownerUser = json['owner_user'];
    address = json['address'];
    photo = json['photo'];
    percentRate = json['percent_rate'];
    ownerPhone = json['owner_phone'];
    oAddBy = json['o_add_by'];
    addByUser = json['add_by_user'];
    addDate = json['add_date'];
    oUpdateBy = json['o_update_by'];
    updateByUser = json['update_by_user'];
    updateDate = json['update_date'];
    ud_fcm_token_id = json['ud_fcm_token_id'];
    o_instructions = json['o_instructions'];
    delivery_name = json['delivery_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['o_id'] = oId;
    data['o_num'] = oNum;
    data['o_date'] = oDate;
    data['c_id'] = cId;
    data['c_name'] = cName;
    data['c_phone'] = cPhone;
    data['c_address'] = cAddress;
    data['o_total'] = oTotal;
    data['o_service_fee'] = oServiceFee;
    data['o_delivery_fee'] = oDeliveryFee;
    data['o_tax'] = oTax;
    data['o_net_amount'] = oNetAmount;
    data['o_status'] = oStatus;
    data['o_from_name'] = oFromName;
    data['o_from_latitude'] = oFromLatitude;
    data['o_from_longitude'] = oFromLongitude;
    data['o_to_name'] = oToName;
    data['o_to_latitude'] = oToLatitude;
    data['o_to_longitude'] = oToLongitude;
    data['o_duration'] = oDuration;
    data['o_distance'] = oDistance;
    data['o_delivery_id'] = oDeliveryId;
    data['o_accept_state'] = oAcceptState;
    data['o_problem'] = oProblem;
    data['o_owner_id'] = oOwnerId;
    data['o_delivered_state'] = oDeliveredState;
    data['o_delivered_photo'] = oDeliveredPhoto;
    data['owner_user'] = ownerUser;
    data['address'] = address;
    data['photo'] = photo;
    data['percent_rate'] = percentRate;
    data['owner_phone'] = ownerPhone;
    data['o_add_by'] = oAddBy;
    data['add_by_user'] = addByUser;
    data['add_date'] = addDate;
    data['o_update_by'] = oUpdateBy;
    data['update_by_user'] = updateByUser;
    data['update_date'] = updateDate;

    return data;
  }
}