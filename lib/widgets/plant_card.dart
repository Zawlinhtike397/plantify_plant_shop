import 'package:flutter/material.dart';

class PlantsCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  const PlantsCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    double widthValue = MediaQuery.of(context).size.width;
    double heightValue = MediaQuery.of(context).size.height;
    // print('widthValue: $widthValue');
    // print('heightValue: $heightValue');

    return Card(
      color: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 7 / 8,
                  child: Image.asset(
                    image,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              // 'Lucky Jade Plant',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$$price",
                  // "\$ 12.99",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(
                        10), // Adjust padding to change button size
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.favorite,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
