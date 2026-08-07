import 'package:flutter/material.dart';
import 'offer_model.dart';

class OfferCardWidget extends StatelessWidget {
  final Offer offer;
  final VoidCallback onAddTap;

  const OfferCardWidget({
    super.key,
    required this.offer,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            offer.imagePath,
            width: 110,
            height: 110,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 110,
              height: 110,
              color: Colors.grey[200],
              child: const Icon(Icons.fastfood, color: Colors.grey, size: 40),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  offer.description,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '${offer.newPrice} EGP',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    if (offer.oldPrice.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        offer.oldPrice,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAddTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}