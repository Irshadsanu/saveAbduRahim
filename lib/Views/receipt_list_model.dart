class PaymentDetails {
  String id;
  String amount;
  String name;
  String paymentApp;
  String phoneNumber;
  String status;
  String time;
  String state;
  String district;
  String assembly;
  String upiId;
  String refNo;
  String receiptStatus;
  String paymentUpiId;
  String enroller;
  String nameStatus;
  String enrollerId;
  String paymentplatform;
  String deviceId;

  PaymentDetails(
    this.id,
    this.amount,
    this.name,
    this.paymentApp,
    this.phoneNumber,
    this.status,
    this.time,
    this.state,
    this.district,
    this.assembly,
    this.upiId,
    this.refNo,
    this.receiptStatus,
    this.paymentUpiId,
      this.enroller,
      this.nameStatus,
      this.enrollerId,
      this.paymentplatform,
      this.deviceId,
  );
}
class GetDetails{

  String amount;
  String name;

  GetDetails(this.amount,this.name);

}

class GetPhoneNumber{

  String name;
  String phone;
  String tid;
  String amount;
  String status;


  GetPhoneNumber(this.name,this.phone,this.tid,this.amount,this.status);


}


