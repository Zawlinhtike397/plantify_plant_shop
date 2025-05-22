import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:plantshop_app/screens/cart_screen.dart';

class CheckoutScreen extends StatefulWidget {
  double subTotalValue;
  double totalValue;
  num totalQuantityValue;

  CheckoutScreen({
    super.key,
    required this.subTotalValue,
    required this.totalValue,
    required this.totalQuantityValue,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<String> shippingOptions = ['Option1', 'Option2'];
  late String _selectedShippingOption;

  List<String> paymentOptions = [
    'Credit card',
    'Paypal',
    'Google pay',
    'Apple'
  ];
  late String _selectedPaymentOption;
  List<String> paymentImages = [
    'assets/image/MasterCard.png',
    'assets/image/PayPal.png',
    'assets/image/GooglePay.png',
    'assets/image/Apple.png'
  ];

  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> placeDescriptionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> addressControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  // final TextEditingController placeDescriptionController =
  //     TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController placeDescriptionController2 =
  //     TextEditingController();
  // final TextEditingController phoneNumberController2 = TextEditingController();
  // final TextEditingController addressController2 = TextEditingController();

  List<String> placeDescriptions = ['Home', 'Work'];
  List<String> phoneNumbers = ['09-232324421', '09-876543210'];
  List<String> addresses = [
    'Yangon, Shwe Pyi Thar',
    'Mandalay, Chan Aye Thar Zan'
  ];

  void initState() {
    super.initState();
    _selectedShippingOption = shippingOptions[0];
    _selectedPaymentOption = paymentOptions[0];

    // for (int i = 0; i < shippingOptions.length; i++) {
    //   placeDescriptionControllers[i].text = placeDescriptions[i];
    //   phoneNumberControllers[i].text = phoneNumbers[i];
    //   addressControllers[i].text = addresses[i];
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 37.0,
                ),
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
              ),
              if (widget.totalQuantityValue > 0)
                Positioned(
                  top: 5,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.totalQuantityValue < 10
                          ? '0${widget.totalQuantityValue.toString()}'
                          : widget.totalQuantityValue.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping to',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shippingOptions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio.adaptive(
                                value: shippingOptions[index],
                                groupValue: _selectedShippingOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedShippingOption = value!;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      placeDescriptions[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      phoneNumbers[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            // fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      addresses[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            // fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: Colors.black,
                                iconSize: 20,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                        title:
                                            const Text('Edit Destination Info'),
                                        content: SizedBox(
                                          height: 280,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                const Text('Place description'),
                                                TextFormField(
                                                  controller:
                                                      placeDescriptionControllers[
                                                          index],
                                                  decoration: InputDecoration(
                                                    hintText: 'eg. Home',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          // fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter place description';
                                                    }
                                                  },
                                                ),
                                                const Text('Your phone number'),
                                                TextFormField(
                                                  controller:
                                                      phoneNumberControllers[
                                                          index],
                                                  decoration: InputDecoration(
                                                    hintText: 'eg. 092xxxx34',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          // fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter your phone number';
                                                    }
                                                    // return value;
                                                  },
                                                ),
                                                const Text('Your address'),
                                                TextFormField(
                                                  controller:
                                                      addressControllers[index],
                                                  decoration: InputDecoration(
                                                    hintText: 'eg. E street',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          // fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter your address';
                                                    }
                                                  },
                                                ),
                                                Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() {
                                                            placeDescriptions[
                                                                    index] =
                                                                placeDescriptionControllers[
                                                                        index]
                                                                    .text;
                                                            phoneNumbers[
                                                                    index] =
                                                                phoneNumberControllers[
                                                                        index]
                                                                    .text;
                                                            addresses[index] =
                                                                addressControllers[
                                                                        index]
                                                                    .text;
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        }
                                                      },
                                                      child: const Text('Save'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentOptions.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                paymentImages[index],
                                width: 70,
                              ),
                              Text(
                                paymentOptions[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                          Radio(
                            value: paymentOptions[index],
                            groupValue: _selectedPaymentOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentOption = value!;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

//Above is testing CODEEEE

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            // height: 150, //container height is causing overflow why?
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 27.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub total',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            '\$${widget.subTotalValue.toStringAsFixed(2)}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const DottedLine(),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          Text(
                            '\$${widget.totalValue.toStringAsFixed(2)}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 17),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Place to Order',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
