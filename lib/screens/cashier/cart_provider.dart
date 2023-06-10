import 'package:flutter/foundation.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';

class CartProvider with ChangeNotifier {
  List<ClickedItem> clickedItems = [];

  void addToCart(ClickedItem clickedItem) {
    clickedItems.add(clickedItem);
    notifyListeners();
  }

  void clearCart() {
    clickedItems.clear();
    notifyListeners();
  }
}


// class ClickedItem {
//   final String name;
//   final int amount;
//   final int totalPrice;

//   ClickedItem({
//     required this.name,
//     required this.amount,
//     required this.totalPrice,
//   });
// }
