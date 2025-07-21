import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/language_provider.dart';
import '../providers/cart_provider.dart';
import 'tabs/home_tab.dart';
import 'tabs/categories_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.isArabic;
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: IndexedStack(
              index: _currentIndex,
              children: [HomeTab(), CategoriesTab(), CartTab(), ProfileTab()],
            ),
            bottomNavigationBar: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      unselectedItemColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                      selectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            _currentIndex == 0
                                ? Iconsax.home_15
                                : Iconsax.home_1,
                          ),
                          label: isArabic ? 'الرئيسية' : 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            _currentIndex == 1
                                ? Iconsax.category5
                                : Iconsax.category,
                          ),
                          label: isArabic ? 'التصنيفات' : 'Categories',
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(
                            children: [
                              Icon(
                                _currentIndex == 2
                                    ? Iconsax.bag_25
                                    : Iconsax.bag_2,
                              ),
                              if (cartProvider.itemCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Text(
                                      '${cartProvider.itemCount}',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          label: isArabic ? 'السلة' : 'Cart',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            _currentIndex == 3
                                ? Iconsax.profile_2user5
                                : Iconsax.profile_2user,
                          ),
                          label: isArabic ? 'الملف الشخصي' : 'Profile',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
