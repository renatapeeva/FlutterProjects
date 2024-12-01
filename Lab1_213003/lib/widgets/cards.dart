import 'package:flutter/material.dart';
import 'package:lab_213003/models/clothingItem.dart';


class ClothingCard extends StatelessWidget {
  final ClothingItem item;

  ClothingCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/details',
          arguments: ClothingItem(
              id: item.id,
              name: item.name,
              imageUrl: item.imageUrl,
              description: item.description,
              price: item.price)),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              item.name,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
