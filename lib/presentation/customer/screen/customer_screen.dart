import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenxglobal_customer/presentation/connection_screen/widgets/connection_wrapper.dart'
    as cw;
import 'package:tenxglobal_customer/presentation/customer/provider/customer_provider.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return cw.ConnectivityWrapper(
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.zero,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/smashNGrub.jpeg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          // Black overlay with opacity
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            // 0.4 = 40% dim
                          ),
                          // Center(
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         'The Tasty House',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 30.0,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       SizedBox(height: 12.0),
                          //       Text(
                          //         'Where taste meets comfort and every meal feels like home.',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 20.0,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Consumer<CustomerProvider>(
                      builder: (context, provider, _) {
                        final order =
                            provider.orders == null || provider.orders.isEmpty
                            ? null
                            : provider.orders.first;
                        final items = order == null
                            ? []
                            : order.cartData.items ?? [];

                        return items.isEmpty
                            ? SizedBox.shrink()
                            : Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        255,
                                        121,
                                        120,
                                        120,
                                      ),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// ---------------- HEADER ----------------
                                      Container(
                                        height: 70.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1B1670),
                                        ),
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Text(
                                              order != null
                                                  ? order.cartData.orderType
                                                  : 'Takeaway',
                                              style: const TextStyle(
                                                color: Color(0xFF1B1670),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 20.0),

                                      /// WRAP THIS ENTIRE SECTION WITH EXPANDED
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// ---------------- CUSTOMER ----------------
                                              const Text(
                                                'Customer',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),

                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.0,
                                                      ),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                child: Text(
                                                  order != null
                                                      ? order.cartData.customer
                                                      : 'Walk-in',
                                                ),
                                              ),

                                              const SizedBox(height: 12.0),

                                              /// ---------------- ITEMS ----------------
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12.0,
                                                        ),
                                                    border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ),
                                                  child: items.isEmpty
                                                      ? const Center(
                                                          child: Text(
                                                            'No items',
                                                          ),
                                                        )
                                                      : ListView.separated(
                                                          itemCount:
                                                              items.length,
                                                          separatorBuilder:
                                                              (_, __) =>
                                                                  const Divider(
                                                                    thickness:
                                                                        0.3,
                                                                  ),
                                                          itemBuilder: (context, index) {
                                                            final item =
                                                                items[index];
                                                            return Row(
                                                              children: [
                                                                Image.network(
                                                                  item.img,
                                                                  height: 45,
                                                                ),

                                                                // /// ITEM IMAGE
                                                                // const Icon(
                                                                //   Icons.fastfood,
                                                                //   size: 45,
                                                                // ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),

                                                                /// NAME
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        item.title ??
                                                                            '',
                                                                      ),
                                                                      item.variantName ==
                                                                              null
                                                                          ? SizedBox()
                                                                          : Text(
                                                                              "Varient: ${item.variantName}",
                                                                            ),

                                                                      // if (item
                                                                      //     .addons
                                                                      //     .isNotEmpty)
                                                                      //   Text(
                                                                      //     'Addons:',
                                                                      //     style: TextStyle(
                                                                      //       fontSize:
                                                                      //           11,
                                                                      //       fontWeight:
                                                                      //           FontWeight
                                                                      //               .bold,
                                                                      //       color: Colors
                                                                      //           .grey[800],
                                                                      //     ),
                                                                      //   ),
                                                                      Wrap(
                                                                        children: item
                                                                            .addons
                                                                            .map<
                                                                              Widget
                                                                            >((
                                                                              addon,
                                                                            ) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.symmetric(
                                                                                  horizontal: 2.0,
                                                                                  vertical: 0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.all(
                                                                                    4.0,
                                                                                  ),

                                                                                  child: Text(
                                                                                    '${addon.name} (£${addon.price.toStringAsFixed(2)})',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 11.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            })
                                                                            .toList(),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                /// QTY
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        Color.fromARGB(
                                                                          255,
                                                                          231,
                                                                          231,
                                                                          229,
                                                                        ),
                                                                  ),

                                                                  child: Text(
                                                                    'x${item.qty ?? 0}',
                                                                    style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),

                                                                const SizedBox(
                                                                  width: 8,
                                                                ),

                                                                /// PRICE
                                                                Text(
                                                                  '£ ${item.price?.toStringAsFixed(2) ?? '0.00'}',
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                ),
                                              ),

                                              const SizedBox(height: 5.0),
                                              const Divider(thickness: 0.5),
                                              const SizedBox(height: 15.0),

                                              /// ---------------- TOTALS ----------------
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Subtotal'),
                                                  Text(
                                                    order != null
                                                        ? '£ ${order.cartData.subtotal.toStringAsFixed(2) ?? '0.00'}'
                                                        : '0.00',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Tax'),
                                                  Text(
                                                    order != null
                                                        ? '£ ${order.cartData.tax.toStringAsFixed(2) ?? '0.00'}'
                                                        : '0.00',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Service'),
                                                  Text(
                                                    order != null
                                                        ? '£ ${order.cartData.serviceCharges.toStringAsFixed(2) ?? '0.00'}'
                                                        : '0.00',
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 5.0),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Sale Discount',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    order != null
                                                        ? '- £ ${order.cartData.saleDiscount.toStringAsFixed(2) ?? '0.00'}'
                                                        : '0.00',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 5.0),
                                              const Divider(thickness: 0.5),
                                              const SizedBox(height: 5.0),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    order != null
                                                        ? '£ ${order.cartData.total.toStringAsFixed(2) ?? '0.00'}'
                                                        : '0.00',
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
