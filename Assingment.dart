import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 20),
    Product(name: "Product 3", price: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(products)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int quantity = 0;

  Product({required this.name, required this.price});
}

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.name),
      subtitle: Text('\$${widget.product.price.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${widget.product.quantity}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                widget.product.quantity++;
                if (widget.product.quantity == 5) {
                  _showCongratulationsDialog(context, widget.product.name);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void _showCongratulationsDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 $productName!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  int getTotalQuantity() {
    int total = 0;
    for (var product in products) {
      total += product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products in Cart: ${getTotalQuantity()}'),
      ),
    );
  }
}
