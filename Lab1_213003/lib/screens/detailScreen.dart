import 'package:flutter/material.dart';
import 'package:lab_213003/models/clothingItem.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ClothingItem;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
      ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(arguments.imageUrl,
                fit: BoxFit.fill, height: 350, alignment: Alignment.center),
          ),
          Container(
            child: Text(
              arguments.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              arguments.description,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            child: Text(
              "\$${arguments.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: OutlinedButton(
              child: Text(
                "Buy",
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {},
              ),
            )
          ],
       ),
      ),
    );
  }
}
