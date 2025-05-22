import 'package:flutter/material.dart';
import 'package:plantshop_app/providers/cart_provider_state.dart';
import 'package:plantshop_app/screens/checkout_screen.dart';
import 'package:provider/provider.dart';
// import 'package:plantui_heyflutter/screens/homepage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int activePage = 0;
  final TextEditingController cuponCodeController = TextEditingController();
  final PageController _pageViewController = PageController();

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     //?
  //     Provider.of<NavigationProvider>(context, listen: false)
  //         .setShowBottomNavBar(false);
  //   });
  // }

  @override
  void dispose() {
    // Provider.of<NavigationProvider>(context, listen: false)
    //     .setShowBottomNavBar(true);
    super.dispose();
    cuponCodeController.dispose();
  }

  void onTapBottomNav(int pageIndex) {
    _pageViewController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProviderState>();
    final cart = cartProvider.cartData;

    num totalQuantity = 0;
    double subTotal = 0.0;
    for (var cartItem in cart) {
      subTotal += (cartItem['price'] * cartItem['quantity']);
      totalQuantity += cartItem['quantity'];
    }

    const double deliveryFee = 3.46;
    double total = subTotal + deliveryFee;

    String cuponCode = 'ZORO';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        // actions: [IconButton(onPressed: , icon: icon)],
      ),
      body: cartProvider.cartData.isEmpty
          ? const Center(
              child: Text('Cart is Empty'),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: MediaQuery.of(context).size.width * 0.29,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 7.0,
                        ),
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 20.0,
                                  bottom: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      (cart[i]['imageUrl']),
                                      fit: BoxFit.fitWidth,
                                      // width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cart[i]['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              Text(
                                                '\$${((cart[i]['price'] * cart[i]['quantity'] as double).toStringAsFixed(2))}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  '\$${(cart[i]['price'] as double).toStringAsFixed(2)}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (cart[i]
                                                                ['quantity'] >
                                                            1) {
                                                          cartProvider
                                                              .updateQuantity(
                                                                  i,
                                                                  cart[i]['quantity'] -
                                                                      1);
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(Icons
                                                        .do_not_disturb_on),
                                                    color: Colors.black,
                                                    iconSize: 20,
                                                  ),
                                                  Text(
                                                    cart[i]['quantity'] < 10
                                                        ? '0${cart[i]['quantity']}'
                                                        : '${cart[i]['quantity']}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        cartProvider.updateQuantity(
                                                            i,
                                                            cart[i]['quantity'] +
                                                                1);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.add_circle),
                                                    color: Colors.black,
                                                    iconSize: 20,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -6,
                              right: 3,
                              child: IconButton(
                                onPressed: () {
                                  cartProvider.removeCartData(cart[i]);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 21.0,
                    right: 21.0,
                    bottom: 15.0,
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                    tileColor: Colors.white,
                    leading: Image.asset(
                      'assets/image/Cupons.png',
                      width: 40,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    title: TextField(
                      controller: cuponCodeController,
                      decoration: InputDecoration(
                        hintText: 'Promo Code',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          if (cuponCodeController.text == cuponCode) {
                            for (var cartItem in cart) {
                              cartItem['price'] *= 0.2;
                            }
                          }
                        });
                      },
                      child: const Text(
                        'Apply',
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                    ),
                              ),
                              Text(
                                '\$${subTotal.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 0.7,
                                color: Colors.grey,
                              ),
                              bottom: BorderSide(
                                width: 0.7,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                    ),
                              ),
                              Text(
                                '\$$deliveryFee',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CheckoutScreen(
                                    totalValue: total,
                                    subTotalValue: subTotal,
                                    totalQuantityValue: totalQuantity,
                                  );
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('CHECKOUT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
