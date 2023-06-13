import 'package:flutter/foundation.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';

class CartProvider with ChangeNotifier {
  List<ClickedItem> _clickedItems = [];

  List<ClickedItem> get clickedItems => _clickedItems;

  void addToCart(ClickedItem clickedItem) {
    _clickedItems.add(clickedItem);
    notifyListeners();
  }

  void clearCart() {
    _clickedItems.clear();
    notifyListeners();
  }
}
