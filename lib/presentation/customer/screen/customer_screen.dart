import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenxglobal_customer/presentation/customer/provider/customer_provider.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            'assets/images/login.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Black overlay with opacity
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withValues(
                            alpha: 0.7,
                          ), // 0.4 = 40% dim
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'The Tasty House',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                'Where taste meets comfort and every meal feels like home.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 121, 120, 120),
                          width: 0.5,
                        ),
                      ),
                      child: Consumer<CustomerProvider>(
                        builder: (context, provider, _) {
                          // if (provider.orders.isEmpty ||
                          //     provider.orders.first.order == null) {
                          //   return const Center(child: Text('No Order Found'));
                          // }

                          final order =
                              provider.orders == null || provider.orders.isEmpty
                              ? null
                              : provider.orders.first.order!;
                          final items = order == null ? [] : order.items ?? [];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ---------------- HEADER ----------------
                              Container(
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B1670),
                                  // borderRadius: const BorderRadius.only(
                                  //   topLeft: Radius.circular(16.0),
                                  //   topRight: Radius.circular(16.0),
                                  // ),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      order != null
                                          ? order.orderType ?? 'Takeaway'
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

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      child: Text(
                                        order != null
                                            ? order.customerName ?? 'Walk-in'
                                            : 'Walk-in',
                                      ),
                                    ),

                                    const SizedBox(height: 12.0),

                                    /// ---------------- ITEMS ----------------
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.50,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: ListView(
                                        children: items.map((item) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  /// ITEM IMAGE / ICON
                                                  item.image != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          child: Image.network(
                                                            item.image!,
                                                            width: 45,
                                                            height: 45,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (
                                                                  _,
                                                                  __,
                                                                  ___,
                                                                ) => const Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 50.0,
                                                                ),
                                                          ),
                                                        )
                                                      : const Icon(
                                                          Icons.fastfood,
                                                          size: 45.0,
                                                        ),

                                                  const SizedBox(width: 8.0),

                                                  /// ITEM NAME
                                                  Expanded(
                                                    child: Text(
                                                      item.title ?? '',
                                                    ),
                                                  ),

                                                  /// QTY
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromARGB(
                                                            255,
                                                            231,
                                                            231,
                                                            229,
                                                          ),
                                                        ),
                                                    child: Text(
                                                      'x${item.quantity ?? 0}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),

                                                  const SizedBox(width: 8.0),

                                                  /// PRICE
                                                  Text(
                                                    '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                                                  ),
                                                ],
                                              ),
                                              const Divider(thickness: 0.3),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    const Divider(thickness: 0.5),
                                    const SizedBox(height: 5.0),

                                    /// ---------------- TOTALS ----------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Subtotal'),
                                        Text(
                                          order != null
                                              ? '\$${order.subTotal?.toStringAsFixed(2) ?? '0.00'}'
                                              : '0.00',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Tax'),
                                        Text(
                                          order != null
                                              ? '\$${order.tax?.toStringAsFixed(2) ?? '0.00'}'
                                              : '0.00',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Service'),
                                        Text(
                                          order != null
                                              ? '\$${order.serviceCharges?.toStringAsFixed(2) ?? '0.00'}'
                                              : '0.00',
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 5.0),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sale Discount',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          order != null
                                              ? '-\$${order.salesDiscount?.toStringAsFixed(2) ?? '0.00'}'
                                              : '0.00',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 5.0),
                                    const Divider(thickness: 0.5),
                                    const SizedBox(height: 5.0),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          order != null
                                              ? '\$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}'
                                              : '0.00',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
