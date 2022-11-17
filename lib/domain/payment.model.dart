class Payment {
  late final int user;
  late final String phone;
  late final double amount;
  late final String? receiptNumber;

  Payment(
      {required this.user,
      required this.phone,
      required this.amount,
      this.receiptNumber});

  Payment copyWith({required Payment payment}) {
    return Payment(
        user: payment.user,
        phone: payment.phone,
        amount: payment.amount,
        receiptNumber: payment.receiptNumber);
  }

  static Map<String, dynamic> toMap(Payment payment) {
    Map<String, dynamic> data = {
      "user": payment.user,
      "phone": payment.phone,
      "amount": payment.amount,
      "receiptNumber": payment.receiptNumber,
    };

    return data;
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
        user: json["user"],
        phone: json["phone"],
        amount: json["amount"],
        receiptNumber: json["receiptNumber"]);
  }

  static Payment empty() => Payment(user: 0, phone: "phone", amount: 0);
}
