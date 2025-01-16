// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key, required this.username, required this.password});
//   final String username;
//   final String password;

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   List<Map<String, dynamic>> products = [
//     {'name': 'Rice', 'price': 10.0, 'stock': 100},
//     {'name': 'Noodles', 'price': 15.0, 'stock': 80},
//     {'name': 'Pasta', 'price': 12.0, 'stock': 60},
//   ];

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

// void _showProductDialog({Map<String, dynamic>? product}) {
//   final nameController = TextEditingController(text: product?['name']);
//   final priceController = TextEditingController(text: product?['price']?.toString());
//   final stockController = TextEditingController(text: product?['stock']?.toString());

//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(product == null ? 'Add Product' : 'Edit Product'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: priceController,
//               decoration: const InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: stockController,
//               decoration: const InputDecoration(labelText: 'Stock'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               final String name = nameController.text.trim();
//               final double? price = double.tryParse(priceController.text.trim());
//               final int? stock = int.tryParse(stockController.text.trim());

//               if (name.isNotEmpty && price != null && stock != null) {
//                 setState(() {
//                   if (product != null) {
//                     product['name'] = name;
//                     product['price'] = price;
//                     product['stock'] = stock;
//                   } else {
//                     products.add({'name': name, 'price': price, 'stock': stock});
//                   }
//                 });
//                 Navigator.of(context).pop();
//               } else {
//                 // Display an error message if needed
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Please fill all fields with valid data.')),
//                 );
//               }
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       );
//     },
//   ).then((_) {
//     nameController.dispose();
//     priceController.dispose();
//     stockController.dispose();
//   });
// }

//   void _deleteProduct(Map<String, dynamic> product) {
//     setState(() {
//       products.remove(product);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: const [
//             Text('KASIR', style: TextStyle(color: Colors.white)),
//             Text('QU', style: TextStyle(color: Colors.amber)),
//           ],
//         ),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.grid_view),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           ProductScreen(
//             products: products,
//             onEdit: _showProductDialog,
//             onDelete: _deleteProduct,
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Registration'),
//           BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
//         ],
//         selectedItemColor: Colors.blue,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showProductDialog(),
//         backgroundColor: Colors.grey,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ProductScreen extends StatelessWidget {
//   const ProductScreen({
//     super.key,
//     required this.products,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   final List<Map<String, dynamic>> products;
//   final void Function(Map<String, dynamic>? product) onEdit;
//   final void Function(Map<String, dynamic> product) onDelete;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return ListTile(
//           title: Text(product['name']),
//           subtitle: Text('Price: ${product['price']} - Stock: ${product['stock']}'),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.edit),
//                 onPressed: () => onEdit(product),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () => onDelete(product),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username, required this.password});
  final String username;
  final String password;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String name = nameController.text.trim();
                final String priceText = priceController.text.trim();
                final String stockText = stockController.text.trim();

                if (name.isNotEmpty &&
                    priceText.isNotEmpty &&
                    stockText.isNotEmpty) {
                  final double? price = double.tryParse(priceText);
                  final int? stock = int.tryParse(stockText);

                  if (price != null && stock != null) {
                    setState(() {
                      products
                          .add({'nama_produk': name, 'harga': price, 'stok': stock});
                    });
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Please enter valid numbers for Price and Stock.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      priceController.dispose();
      stockController.dispose();
    });
  }

  Future<void> fetchProducts() async {
    final response = await Supabase.instance.client.from('produk').select();
    setState(() {
      products = response as List<Map<String, dynamic>>;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('KASIR', style: TextStyle(color: Colors.white)),
            Text('QU', style: TextStyle(color: Colors.amber)),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ProductScreen(
            products: products,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Registration'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
        ],
        selectedItemColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddProductDialog(), // Menampilkan dialog untuk menambahkan produk
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.products,
  });

  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product['nama_produk']),
          subtitle:
              Text('Price: ${product['harga']} - Stock: ${product['stok']}'),
        );
      },
    );
  }
}
