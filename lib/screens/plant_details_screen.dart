import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plantshop_app/providers/cart_provider_state.dart';
import 'package:plantshop_app/screens/cart_screen.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlantDetailsScreen extends StatefulWidget {
  final Map<String, Object> plant;
  const PlantDetailsScreen({super.key, required this.plant});

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  final _controller = PageController();
  late List<Image> allImages;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    print(screenHeight);
    print(screenWidth);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        body: screenWidth < 724
            ? Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 724),
                    child: Column(
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: screenHeight < 667
                              ? screenHeight * 0.5
                              : screenHeight * 0.7,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 360),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: PageView.builder(
                                    itemCount: 3,
                                    scrollDirection: Axis.vertical,
                                    controller: _controller,
                                    itemBuilder: ((context, index) {
                                      return Image.asset(
                                        (widget.plant['imageUrl']
                                            as List<String>)[0],
                                        // fit: BoxFit.contain,
                                        width: 280,
                                      );
                                    }),
                                  ),
                                ),
                                Positioned(
                                  bottom: widget.plant['id'] == '3' ? 36 : 0,
                                  right: 85,
                                  child: SmoothPageIndicator(
                                    axisDirection: Axis.vertical,
                                    controller: _controller,
                                    count: 3,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 6.0,
                                      dotWidth: 6.0,
                                      activeDotColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.plant['name']}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${widget.plant['description']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxHeight:
                                  // screenHeight < 667 ? 100 :
                                  200),
                          decoration: BoxDecoration(
                            // border: ,
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    40.0, 20.0, 40.0, 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.height,
                                          size: 34,
                                        ),
                                        Text(
                                          'Height',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          widget.plant['height'] as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.device_thermostat_outlined,
                                          size: 34,
                                        ),
                                        Text(
                                          'Temperature',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          widget.plant['temperature'] as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.inventory_2_outlined,
                                          size: 34,
                                        ),
                                        Text(
                                          'Pot',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.plant['pot'] as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    50.0, 0, 35.0, 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Price',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                        ),
                                        Text(
                                          '\$${widget.plant['price']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 45, vertical: 23),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Provider.of<CartProviderState>(context,
                                                listen: false)
                                            .addCartData({
                                          'id': widget.plant['id'],
                                          'name': widget.plant['name'],
                                          'price': widget.plant['price'],
                                          'height': widget.plant['height'],
                                          'temperature':
                                              widget.plant['temperature'],
                                          'pot': widget.plant['pot'],
                                          'imageUrl': (widget.plant['imageUrl']
                                              as List<String>)[0],
                                          'description':
                                              widget.plant['description'],
                                        });
                                      },
                                      child: const Text(
                                        'Add to Cart',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: SizedBox(
                                height: screenHeight * 0.8,
                                child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 340),
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      children: [
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 2,
                                          mainAxisCellCount: 2,
                                          child: Card(
                                            child: Image.asset(
                                              (widget.plant['imageUrl']
                                                  as List<String>)[0],
                                            ),
                                          ),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: Card(
                                            child: Image.asset(
                                              (widget.plant['imageUrl']
                                                  as List<String>)[0],
                                            ),
                                          ),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                          child: Card(
                                            child: Image.asset(
                                              (widget.plant['imageUrl']
                                                  as List<String>)[0],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.plant['name']}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.plant['description']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 200),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40.0, 20.0, 40.0, 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            const Icon(
                                              Icons.height,
                                              size: 34,
                                            ),
                                            Text(
                                              'Height',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              widget.plant['height'] as String,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.device_thermostat_outlined,
                                              size: 34,
                                            ),
                                            Text(
                                              'Temperature',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              widget.plant['temperature']
                                                  as String,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.inventory_2_outlined,
                                              size: 34,
                                            ),
                                            Text(
                                              'Pot',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.plant['pot'] as String,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50.0, 0, 35.0, 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Price',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                            Text(
                                              '\$${widget.plant['price']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            Provider.of<CartProviderState>(
                                                    context,
                                                    listen: false)
                                                .addCartData({
                                              'id': widget.plant['id'],
                                              'name': widget.plant['name'],
                                              'price': widget.plant['price'],
                                              'height': widget.plant['height'],
                                              'temperature':
                                                  widget.plant['temperature'],
                                              'pot': widget.plant['pot'],
                                              'imageUrl':
                                                  (widget.plant['imageUrl']
                                                      as List<String>)[0],
                                              'description':
                                                  widget.plant['description'],
                                            });
                                          },
                                          child: const Text(
                                            'Add to Cart',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
