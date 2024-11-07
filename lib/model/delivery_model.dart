
class DeliveryItem {
  final String status;
  final String orderNumber;
  final String date;
  final String time;
  final String price;
  final String paymentMethod;
  final String address;

  DeliveryItem({
    required this.status,
    required this.orderNumber,
    required this.date,
    required this.time,
    required this.price,
    required this.paymentMethod,
    required this.address,
  });
}
