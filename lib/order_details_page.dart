import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/provider/clothlist_provider.dart';
import '../provider/order_provider.dart';
import '../colors.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final clothListProvider = Provider.of<ClothListProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order No. ${orderProvider.order.orderNumber}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: primary, // Set indicator color to primary
            labelColor: primary, // Set active tab text color to primary
            unselectedLabelColor: Colors.grey, // Optional: Set inactive tab text color
            tabs: [
              Tab(text: 'Order Info'),
              Tab(text: 'Cloth List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Order Info Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ordered By',
                                    style: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    orderProvider.order.orderedBy,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(Icons.call, color: primary),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Status',
                                    style: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    orderProvider.order.orderStatus,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: primary,
                                child: Icon(Icons.local_shipping, color: Colors.white, size: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Pick Up', style: TextStyle(fontSize: 18, color: Colors.grey)),
                              Text('Delivery', style: TextStyle(fontSize: 18, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Date: ${orderProvider.order.date}', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Time: ${orderProvider.order.time}', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Date: ${orderProvider.order.date}', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Time: ${orderProvider.order.time}', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pickup Address', style: TextStyle(color: Colors.grey, fontSize: 18)),
                              SizedBox(height: 5),
                              Text(orderProvider.order.pickupAddress, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Icon(Icons.telegram, color: primary, size: 50),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Payment Information Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Method',
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                orderProvider.order.paymentMethod,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₹${orderProvider.order.price.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        orderProvider.markDelivered();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: primary,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Mark Delivered', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Cloth List Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: clothListProvider.clothList.length,
                      itemBuilder: (context, index) {
                        final cloth = clothListProvider.clothList[index];
                        return ListTile(
                          title: Text(cloth.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text(cloth.purpose, style: TextStyle(color: Colors.grey)),
                          trailing: Text('₹${cloth.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${orderProvider.order.paymentMethod}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Total: ₹${orderProvider.order.price}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        orderProvider.markDelivered();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: primary,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Mark Delivered', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
