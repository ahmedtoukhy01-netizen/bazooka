import 'package:flutter/material.dart';
import 'offer_model.dart';

class OrderScreen extends StatefulWidget {
  final Offer offer;

  const OrderScreen({super.key, required this.offer});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List<Map<String, dynamic>> sizes;
  late String selectedSize;
  String? selectedLevel1;
  List<String> selectedLevel2 = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    final double basePrice = double.tryParse(widget.offer.newPrice) ?? 0.0;

    sizes = [
      {'title': 'Single', 'price': basePrice},
      {'title': 'Double', 'price': basePrice + 60.0},
      {'title': 'Triple', 'price': basePrice + 85.0},
    ];
    selectedSize = sizes.first['title'];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 220,
                            width: double.infinity,
                            color: Colors.white,
                            child: Image.asset(
                              widget.offer.imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[900],
                                    child: const Icon(
                                      Icons.fastfood,
                                      size: 80,
                                      color: Colors.yellow,
                                    ),
                                  ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 12,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD700),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.file_upload_outlined),
                              label: const Text(
                                'مشاركة الوجبة',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.my_location,
                                  color: Color(0xFFFFD700),
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    widget.offer.title,
                                    style: const TextStyle(
                                      color: Color(0xFFFFD700),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '✦ ${widget.offer.description}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '✦ السعر : ${widget.offer.newPrice} EGP',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (widget.offer.oldPrice.isNotEmpty) ...[
                                  const SizedBox(width: 10),
                                  Text(
                                    '${widget.offer.oldPrice} EGP',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 20),

                            const SectionTitle(
                              title: 'اختر حجم الوجبة (اختر 1)',
                            ),
                            ...sizes.map((size) {
                              return RadioListTile<String>(
                                activeColor: Colors.green,
                                value: size['title'],
                                groupValue: selectedSize,
                                title: Text(
                                  '${size['title']} (${size['price']} EGP)',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedSize = value;
                                    });
                                  }
                                },
                              );
                            }),
                            const SizedBox(height: 16),

                            const SectionTitle(
                              title: '( اختر على الأقل 1 ) Level 1',
                            ),
                            ...['ساندوتش سبايسى', 'ساندوتش عادى'].map((option) {
                              final isChecked = selectedLevel1 == option;
                              return CheckboxListTile(
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                value: isChecked,
                                title: Text(
                                  option,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    selectedLevel1 = isChecked ? null : option;
                                  });
                                },
                              );
                            }),
                            const SizedBox(height: 16),

                            const SectionTitle(
                              title: 'Level 2 (you can choose)',
                            ),
                            ...[
                              {'title': 'Fries + juice', 'price': 65.0},
                              {'title': 'Sandwiches', 'price': 0.0},
                              {'title': 'Fries + Bazooka', 'price': 65.0},
                              {'title': 'Fries + Vcola', 'price': 70.0},
                            ].map((option) {
                              final String title = option['title'] as String;
                              final double price = option['price'] as double;
                              final isChecked = selectedLevel2.contains(title);
                              final titleText = price > 0
                                  ? '$title ($price EGP)'
                                  : title;

                              return CheckboxListTile(
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                value: isChecked,
                                title: Text(
                                  titleText,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    if (isChecked) {
                                      selectedLevel2.remove(title);
                                    } else {
                                      selectedLevel2.add(title);
                                    }
                                  });
                                },
                              );
                            }),
                            const SizedBox(height: 24),

                            const Center(
                              child: Text(
                                'عدد الوجبات',
                                style: TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Container(
                                width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Color(0xFFFFD700),
                                      ),
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(() => quantity--);
                                        }
                                      },
                                    ),
                                    Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Color(0xFFFFD700),
                                      ),
                                      onPressed: () {
                                        setState(() => quantity++);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'اضف لعربة التسوق »',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFFFD700), width: 1.5),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFFD700),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
