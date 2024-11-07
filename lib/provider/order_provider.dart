import 'package:flutter/material.dart';
import '../model/order_model.dart';

class OrderProvider with ChangeNotifier {
  // Mock order data
  Order _order = Order(
    orderNumber: '123456',
    orderedBy: 'John Doe',
    orderStatus: 'Ready to Deliver',
    date: '12-12-2024',
    time: '10:00 AM',
    pickupAddress: '123 Street, City',
    paymentMethod: 'Cash on Delivery',
    price: 500.0,
  );

  Order get order => _order;

  void markDelivered() {
    // Logic for marking order as delivered (e.g., updating status)
    _order = Order(
      orderNumber: _order.orderNumber,
      orderedBy: _order.orderedBy,
      orderStatus: 'Delivered', // Update the order status
      date: _order.date,
      time: _order.time,
      pickupAddress: _order.pickupAddress,
      paymentMethod: _order.paymentMethod,
      price: _order.price,
    );
    notifyListeners();
  }
}
