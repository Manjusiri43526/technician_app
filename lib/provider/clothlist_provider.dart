import 'package:flutter/material.dart';

import '../model/cloth_item_model.dart';

class ClothListProvider with ChangeNotifier {
  List<ClothItem> _clothList = [
    ClothItem(name: 'Top', purpose: 'Iron', price: 30.0),
    ClothItem(name: 'Jeans', purpose: 'Wash', price: 50.0),
  ];

  List<ClothItem> get clothList => _clothList;
}
