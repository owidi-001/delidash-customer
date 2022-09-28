class OrderItem {
  final int id;
  final int order;
  final int product;
  final int quantity;
  final String status;

  OrderItem(
      {required this.id,
      required this.order,
      required this.product,
      required this.quantity,
      required this.status});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: int.parse(json["id"]),
        order: int.parse(json["order"]),
        product: int.parse(json["product"]),
        quantity: int.parse(json["quantity"]),
        status: json["status"]);
  }
}

class Order {
  final int id;
  final int customer;
  final String status;
  final double total;
  final String dateOrdered;
  final int deliveryAddress;

  Order(
      {required this.id,
      required this.customer,
      required this.status,
      required this.total,
      required this.dateOrdered,
      required this.deliveryAddress});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: int.parse(json["id"]),
        customer: int.parse(json["customer"]),
        status: json["status"],
        total: double.parse(json["total"]),
        dateOrdered: json["date"],
        deliveryAddress: int.parse("delivery_address"));
  }
}
