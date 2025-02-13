import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(name: 'Apple', stock: 100),
    Product(name: 'Bag', stock: 50),
    Product(name: 'Grape', stock: 40),
  ];

  List<Product> get products => _products;

  void sellProduct(Product product, int quantity) {
    if (quantity > 0 && quantity <= product.stock) {
      product.stock -= quantity;
      product.sold += quantity;
      notifyListeners();
    }
  }

  void transferProduct(Product product, int quantity) {
    if (quantity > 0 && quantity <= product.stock) {
      product.stock -= quantity;
      product.transferred += quantity;
      notifyListeners();
    }
  }
}
