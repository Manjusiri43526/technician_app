
class Order {
  final String orderNumber;
  final String orderedBy;
  final String orderStatus;
  final String date;
  final String time;
  final String pickupAddress;
  final String paymentMethod;
  final double price;

  Order({
    required this.orderNumber,
    required this.orderedBy,
    required this.orderStatus,
    required this.date,
    required this.time,
    required this.pickupAddress,
    required this.paymentMethod,
    required this.price,
  });
}
