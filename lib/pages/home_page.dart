import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}

final List<Product> products = [
  Product("Laptop", 170000000),
  Product("RAM", 4000000),
  Product("CPU", 3700000),
  Product("Fan", 300000),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentProudctIndex = 0;

  int? _inputedPrice;
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          Text(products[_currentProudctIndex].name),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextField(
              key: const Key("priceInput"),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String value) {
                _inputedPrice = int.tryParse(value);
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _result = _inputedPrice == products[_currentProudctIndex].price
                    ? "pass"
                    : "fail";

                // if (_currentProudctIndex < products.length - 1) {
                //   _currentProudctIndex++;
                // }
              });
            },
            child: const Text("Check"),
          ),
          Visibility(
            visible: _result.isNotEmpty,
            child: Text(
              _result,
              key: const Key("result"),
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: _result.isNotEmpty,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = "";

                  if (_currentProudctIndex < products.length - 1) {
                    _currentProudctIndex++;
                  }
                });
              },
              child: const Text("Next"),
            ),
          ),
        ],
      )),
    );
  }
}
