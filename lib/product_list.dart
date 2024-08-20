import 'package:flutter/material.dart';
import 'package:shop_app/product_details.dart';

import 'data.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> brands = ["All", "Puma", "Nike", "Adidas"];
  late String selectedBrand;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedBrand = brands[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Shoes \n Collection",
                  style: Theme.of(context).textTheme.titleLarge),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final String brand = brands[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBrand = brand;
                      });
                    },
                    child: Chip(
                      label: Text(
                        brand,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      backgroundColor: selectedBrand == brand
                          ? const Color.fromRGBO(153, 204, 255, 1)
                          : const Color.fromRGBO(237, 235, 105, 1.0),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromRGBO(153, 204, 255, 0),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shoes.length,
              itemBuilder: (context, index) {
                final product = shoes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProductDetails(product: product);
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color:
                            Color.fromRGBO(149, 182, 205, 0.23921568627450981)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] as String,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Rs.${product['price'] as String}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Center(
                          child: Image.network(
                            product['image_url'] as String,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
