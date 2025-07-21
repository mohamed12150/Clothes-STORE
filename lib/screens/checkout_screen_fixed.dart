import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/cart_provider.dart';
import '../providers/language_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();

  String selectedPaymentMethod = 'card';
  bool isProcessing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _processOrder() async {
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );

    if (_formKey.currentState?.validate() != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            languageProvider.isArabic
                ? 'يرجى ملء جميع الحقول المطلوبة'
                : 'Please fill all required fields',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isProcessing = true;
    });

    // Simulate processing
    await Future.delayed(const Duration(seconds: 2));

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderNumber = DateTime.now().millisecondsSinceEpoch.toString();

    cartProvider.clearCart();

    if (mounted) {
      context.pushReplacement('/order-complete', extra: orderNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, CartProvider>(
      builder: (context, languageProvider, cartProvider, child) {
        return Directionality(
          textDirection: languageProvider.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(languageProvider.isArabic ? 'الدفع' : 'Checkout'),
              leading: IconButton(
                icon: Icon(
                  languageProvider.isArabic
                      ? Icons.arrow_forward
                      : Icons.arrow_back,
                ),
                onPressed: () => context.pop(),
              ),
            ),
            body: cartProvider.items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.shopping_cart,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          languageProvider.isArabic
                              ? 'السلة فارغة'
                              : 'Your cart is empty',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/home'),
                          child: Text(
                            languageProvider.isArabic
                                ? 'العودة للتسوق'
                                : 'Continue Shopping',
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order Summary
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    languageProvider.isArabic
                                        ? 'ملخص الطلب'
                                        : 'Order Summary',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartProvider.items.length,
                                    itemBuilder: (context, index) {
                                      final item = cartProvider.items[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    item.image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '${languageProvider.isArabic ? 'المقاس:' : 'Size:'} ${item.size} • ${languageProvider.isArabic ? 'الكمية:' : 'Qty:'} ${item.quantity}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$${item.totalPrice.toStringAsFixed(2)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languageProvider.isArabic
                                            ? 'الإجمالي:'
                                            : 'Total:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Shipping Information
                          Text(
                            languageProvider.isArabic
                                ? 'معلومات الشحن'
                                : 'Shipping Information',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: languageProvider.isArabic
                                  ? 'الاسم الكامل'
                                  : 'Full Name',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Iconsax.user),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return languageProvider.isArabic
                                    ? 'الاسم مطلوب'
                                    : 'Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: languageProvider.isArabic
                                  ? 'العنوان'
                                  : 'Address',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Iconsax.location),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return languageProvider.isArabic
                                    ? 'العنوان مطلوب'
                                    : 'Address is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    labelText: languageProvider.isArabic
                                        ? 'المدينة'
                                        : 'City',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Iconsax.building),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return languageProvider.isArabic
                                          ? 'المدينة مطلوبة'
                                          : 'City is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    labelText: languageProvider.isArabic
                                        ? 'رقم الهاتف'
                                        : 'Phone',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Iconsax.call),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return languageProvider.isArabic
                                          ? 'رقم الهاتف مطلوب'
                                          : 'Phone is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Payment Method
                          Text(
                            languageProvider.isArabic
                                ? 'طريقة الدفع'
                                : 'Payment Method',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          Card(
                            child: Column(
                              children: [
                                RadioListTile<String>(
                                  title: Text(
                                    languageProvider.isArabic
                                        ? 'بطاقة ائتمان'
                                        : 'Credit Card',
                                  ),
                                  subtitle: Text(
                                    languageProvider.isArabic
                                        ? 'فيزا، ماستركارد'
                                        : 'Visa, Mastercard',
                                  ),
                                  value: 'card',
                                  groupValue: selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentMethod = value!;
                                    });
                                  },
                                  secondary: const Icon(Iconsax.card),
                                ),
                                const Divider(height: 1),
                                RadioListTile<String>(
                                  title: Text(
                                    languageProvider.isArabic
                                        ? 'الدفع عند الاستلام'
                                        : 'Cash on Delivery',
                                  ),
                                  subtitle: Text(
                                    languageProvider.isArabic
                                        ? 'ادفع عند وصول الطلب'
                                        : 'Pay when you receive',
                                  ),
                                  value: 'cash',
                                  groupValue: selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentMethod = value!;
                                    });
                                  },
                                  secondary: const Icon(Iconsax.money),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: cartProvider.items.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isProcessing ? null : _processOrder,
                        child: isProcessing
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    languageProvider.isArabic
                                        ? 'جاري المعالجة...'
                                        : 'Processing...',
                                  ),
                                ],
                              )
                            : Text(
                                '${languageProvider.isArabic ? 'اطلب الآن' : 'Place Order'} • \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
