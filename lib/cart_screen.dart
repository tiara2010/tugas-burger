import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> items = [
    {
      "name": "Burger",
      "price": 5000000,
      "quantity": 1,
      "image": "https://i.pinimg.com/jpg"
    },
    {
      "name": "Drink",
      "price": 1500000,
      "quantity": 1,
      "image": "https://i.pinimg.com/.jpg"
    },
  ];

  double get subtotal => items.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  double get tax => subtotal * 0.1;
  double get total => subtotal + tax;

  void editItemQuantity(int index) {
    showDialog(
      context: context,
      builder: (context) {
        int quantity = items[index]['quantity'];
        return AlertDialog(
          title: Text("Edit Quantity"),
          content: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() => quantity--);
                  }
                },
              ),
              Text(quantity.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() => quantity++);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items[index]['quantity'] = quantity;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(items[index]['image']),
                      radius: 30,
                    ),
                    title: Text(items[index]['name']),
                    subtitle: Text("Qty: ${items[index]['quantity']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editItemQuantity(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteItem(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Subtotal"),
              trailing: Text("Rp. ${subtotal.toStringAsFixed(2)}"),
            ),
            ListTile(
              title: Text("PPN (10%)"),
              trailing: Text("Rp. ${tax.toStringAsFixed(2)}"),
            ),
            ListTile(
              title: Text("Total"),
              trailing: Text("Rp. ${total.toStringAsFixed(2)}"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Action for checkout
            },
            child: Text("Checkout", style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ),
    );
  }
}
