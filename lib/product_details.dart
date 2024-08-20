import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    String productTitle = widget.product['title'] ?? "No Description Available";
    List<dynamic> sizes = widget.product['size'] ?? [5];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            productTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Center(
            child: Image.network(widget.product['image_url']),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sizes.length,
                itemBuilder: (context, index) {
                  final size = sizes[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      child: Chip(
                        label: Text(
                          size.toString(),
                        ),
                        backgroundColor: selectedSize == size
                            ? const Color.fromRGBO(153, 204, 255, 1)
                            : const Color.fromRGBO(237, 235, 105, 1.0),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedSize == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Select a Size"),
                    ),
                  );
                } else {
                  // context.read<CartProvider>().addProduct({
                  //   "title": widget.product['title'],
                  //   "price": widget.product['price'],
                  //   "size": selectedSize,
                  //   "image_url": widget.product['image_url']
                  // });
                  Provider.of<CartProvider>(context, listen: false).addProduct({
                    "title": widget.product['title'],
                    "price": widget.product['price'],
                    "size": selectedSize,
                    "image_url": widget.product['image_url']
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Product added to cart successfully"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(237, 235, 105, 1.0),
              ),
              child: Text(
                "Add To Cart",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
