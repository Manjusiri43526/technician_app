import 'package:flutter/material.dart';
import '../model/delivery_model.dart';

class DeliveryProvider with ChangeNotifier {
  // Mock data for "Assigned" deliveries
  final List<DeliveryItem> _assignedDeliveries = [
    DeliveryItem(
      status: "Ready to Deliver",
      orderNumber: "123456",
      date: "12-12-2024",
      time: "10:00 AM",
      price: "₹500",
      paymentMethod: "Paytm",
      address: "123 Street, City",
    ),
    DeliveryItem(
      status: "Ready to Deliver",
      orderNumber: "123457",
      date: "12-12-2024",
      time: "11:30 AM",
      price: "₹250",
      paymentMethod: "Cash",
      address: "456 Avenue, City",
    ),
    DeliveryItem(
      status: "Pending Pickup",
      orderNumber: "123458",
      date: "12-12-2024",
      time: "2:00 PM",
      price: "₹800",
      paymentMethod: "Credit Card",
      address: "789 Boulevard, City",
    ),
    DeliveryItem(
      status: "Ready to Deliver",
      orderNumber: "123459",
      date: "12-12-2024",
      time: "4:00 PM",
      price: "₹1,200",
      paymentMethod: "UPI",
      address: "321 Market Street, City",
    ),
    DeliveryItem(
      status: "Pending Pickup",
      orderNumber: "123460",
      date: "13-12-2024",
      time: "9:00 AM",
      price: "₹950",
      paymentMethod: "Cash",
      address: "654 Road, City",
    ),
  ];

  // Mock data for "Completed" deliveries
  final List<DeliveryItem> _completedDeliveries = [
    DeliveryItem(
      status: "Delivered",
      orderNumber: "654321",
      date: "11-12-2024",
      time: "01:00 PM",
      price: "₹700",
      paymentMethod: "PhonePe",
      address: "456 Avenue, City",
    ),
    DeliveryItem(
      status: "Delivered",
      orderNumber: "654322",
      date: "11-12-2024",
      time: "03:30 PM",
      price: "₹450",
      paymentMethod: "Credit Card",
      address: "123 Park Lane, City",
    ),
    DeliveryItem(
      status: "Delivered",
      orderNumber: "654323",
      date: "10-12-2024",
      time: "05:45 PM",
      price: "₹300",
      paymentMethod: "UPI",
      address: "987 Hilltop, City",
    ),
    DeliveryItem(
      status: "Delivered",
      orderNumber: "654324",
      date: "09-12-2024",
      time: "12:15 PM",
      price: "₹1,100",
      paymentMethod: "Cash",
      address: "852 Lakeview, City",
    ),
    DeliveryItem(
      status: "Delivered",
      orderNumber: "654325",
      date: "08-12-2024",
      time: "10:00 AM",
      price: "₹600",
      paymentMethod: "Paytm",
      address: "369 Sunset Blvd, City",
    ),
  ];

  bool _isAssigned = true;
  bool get isAssigned => _isAssigned;

  // Get deliveries based on the selected segment
  List<DeliveryItem> get deliveries => _isAssigned ? _assignedDeliveries : _completedDeliveries;

  // Toggle between Assigned and Completed sections
  void toggleSection() {
    _isAssigned = !_isAssigned;
    notifyListeners();
  }

  // Mark a delivery as delivered and move it to the completed list
  void markDelivered(int index) {
    final item = _assignedDeliveries.removeAt(index);
    _completedDeliveries.add(
      DeliveryItem(
        status: "Delivered",
        orderNumber: item.orderNumber,
        date: item.date,
        time: item.time,
        price: item.price,
        paymentMethod: item.paymentMethod,
        address: item.address,
      ),
    );
    notifyListeners();
  }
}
