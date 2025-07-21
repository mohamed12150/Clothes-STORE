import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Directionality(
          textDirection: languageProvider.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                languageProvider.isArabic ? 'الملف الشخصي' : 'Profile',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.global),
                  onPressed: () {
                    languageProvider.toggleLanguage();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          languageProvider.isArabic
                              ? 'تم التبديل إلى العربية'
                              : 'Switched to English',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Iconsax.user,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  languageProvider.isArabic
                                      ? 'أحمد محمد'
                                      : 'Ahmed Mohammed',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ahmed@example.com',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            themeProvider.isDarkMode
                                ? Iconsax.moon
                                : Iconsax.sun_1,
                          ),
                          title: Text(
                            languageProvider.isArabic
                                ? 'الوضع المظلم'
                                : 'Dark Mode',
                          ),
                          trailing: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) => themeProvider.toggleTheme(),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    languageProvider.isArabic
                        ? 'مرحباً بك في تطبيق كلوثي!\n\nستجد هنا قريباً المزيد من الميزات مثل:\n• تاريخ الطلبات\n• العناوين المحفوظة\n• طرق الدفع\n• المنتجات المفضلة\n• الإعدادات المتقدمة'
                        : 'Welcome to Clothy!\n\nComing soon you will find more features like:\n• Order History\n• Saved Addresses\n• Payment Methods\n• Favorite Products\n• Advanced Settings',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
