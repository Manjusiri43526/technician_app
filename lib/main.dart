import 'package:flutter/material.dart';
import 'package:technician_app/order_details_page.dart';
import 'package:technician_app/pickup_deliveries.dart';
import 'package:technician_app/profile_page/edit_profile.dart';
import 'package:technician_app/profile_page/profile_page.dart';
import 'package:technician_app/provider/clothlist_provider.dart';
import 'package:technician_app/provider/delivery_provider.dart';
import 'package:technician_app/provider/edit_profile_provider.dart';
import 'package:technician_app/provider/order_provider.dart';
import 'package:technician_app/provider/otp_provider.dart';
import 'package:technician_app/provider/profile_page_provider.dart';
import 'package:technician_app/provider/profile_provider.dart';
import 'package:technician_app/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider()),
      ChangeNotifierProvider<ProfileProvider>(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> EditProfileProvider()),
      ChangeNotifierProvider(create: (_)=> ProfilePageProvider()),
      ChangeNotifierProvider(create: (_)=> DeliveryProvider()),
      ChangeNotifierProvider(create: (_)=> OrderProvider()),
      ChangeNotifierProvider(create: (_)=> ClothListProvider()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const OrderDetailPage(),
    ),
    );
  }
}