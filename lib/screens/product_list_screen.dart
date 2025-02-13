import 'package:flutter/material.dart';
import 'package:product_stock_app/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'summary_screen.dart';

class ProductListScreen extends StatelessWidget {
  void _showActionSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.sell),
              title: Text('Sell'),
              onTap: () => _showQuantityDialog(context, product, 'Sell'),
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows),
              title: Text('Transfer'),
              onTap: () => _showQuantityDialog(context, product, 'Transfer'),
            ),
          ],
        );
      },
    );
  }

  void _showQuantityDialog(
      BuildContext context, Product product, String action) {
    TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${product.name} - Enter quantity to $action:'),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Quantity'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  int qty = int.tryParse(controller.text) ?? 0;
                  final provider =
                      Provider.of<ProductProvider>(context, listen: false);
                  if (action == 'Sell') {
                    provider.sellProduct(product, qty);
                  } else {
                    provider.transferProduct(product, qty);
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            'Product List',
            style: TextStyle(color: Colors.white),
          )),
      body: ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];
          return Card(
            color: Colors.deepPurple.shade50,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(product.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Stock: ${product.stock}'),
              onTap: () => _showActionSheet(context, product),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SummaryScreen()),
            );
          },
          child: Text(
            'Update Summary',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
