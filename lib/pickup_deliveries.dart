// screens/pickup_deliveries_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/provider/delivery_provider.dart';
import '../colors.dart';

class PickupDeliveriesScreen extends StatefulWidget {
  const PickupDeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<PickupDeliveriesScreen> createState() => _PickupDeliveriesScreenState();
}

class _PickupDeliveriesScreenState extends State<PickupDeliveriesScreen> {
  @override
  Widget build(BuildContext context) {
    final deliveryProvider = Provider.of<DeliveryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pickup & Deliveries',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Segment control for Assigned and Completed with underline
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (!deliveryProvider.isAssigned) {
                    deliveryProvider.toggleSection();
                  }
                },
                child: Column(
                  children: [
                    Text(
                      'Assigned',
                      style: TextStyle(
                        color: deliveryProvider.isAssigned ? primary : Colors.grey,
                        fontWeight: deliveryProvider.isAssigned ? FontWeight.bold : FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                    if (deliveryProvider.isAssigned)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 60,
                        color: primary,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  if (deliveryProvider.isAssigned) {
                    deliveryProvider.toggleSection();
                  }
                },
                child: Column(
                  children: [
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: !deliveryProvider.isAssigned ? primary : Colors.grey,
                        fontWeight: !deliveryProvider.isAssigned ? FontWeight.bold : FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                    if (!deliveryProvider.isAssigned)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 70,
                        color: primary,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Delivery List Section
          Expanded(
            child: ListView.builder(
              itemCount: deliveryProvider.deliveries.length,
              itemBuilder: (context, index) {
                final delivery = deliveryProvider.deliveries[index];
                final isAssigned = deliveryProvider.isAssigned;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade200,
                                child: Icon(Icons.local_shipping, color: primary),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      delivery.status,
                                      style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Order No. ${delivery.orderNumber}",
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: isAssigned
                                    ? () => deliveryProvider.markDelivered(index)
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAssigned ? primary : Colors.grey,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                child: Text(
                                  isAssigned ? 'Mark Delivered' : 'Delivered',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Delivery Time', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  Text(delivery.date, style: TextStyle(color: Colors.black, fontSize: 14)),
                                  Text(delivery.time, style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Payment', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  Text(delivery.price, style: TextStyle(color: Colors.black, fontSize: 14)),
                                  Text(delivery.paymentMethod, style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text('Delivery Address', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(
                            delivery.address,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
