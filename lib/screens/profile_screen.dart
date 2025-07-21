import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) => AlertDialog(
            title: Text(languageProvider.isArabic ? 'تسجيل الخروج' : 'Logout'),
            content: Text(languageProvider.isArabic 
                ? 'هل أنت متأكد من تسجيل الخروج؟' 
                : 'Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(), 
                child: Text(languageProvider.isArabic ? 'إلغاء' : 'Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.go('/auth');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(languageProvider.isArabic ? 'تسجيل الخروج' : 'Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order History',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final orders = [
                    {
                      'id': '#12345',
                      'date': '2025-07-15',
                      'total': '129.99',
                      'status': 'Delivered',
                    },
                    {
                      'id': '#12346',
                      'date': '2025-07-10',
                      'total': '89.50',
                      'status': 'Shipped',
                    },
                    {
                      'id': '#12347',
                      'date': '2025-07-05',
                      'total': '199.00',
                      'status': 'Processing',
                    },
                  ];
                  final order = orders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Iconsax.receipt_item, color: Colors.white),
                      ),
                      title: Text('Order ${order['id']}'),
                      subtitle: Text('${order['date']} • ${order['status']}'),
                      trailing: Text(
                        '\$${order['total']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddresses(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Addresses',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Add New'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Iconsax.home, color: Colors.white),
                      ),
                      title: Text('Home'),
                      subtitle: Text('123 Main Street, City, State 12345'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Iconsax.building, color: Colors.white),
                      ),
                      title: Text('Work'),
                      subtitle: Text(
                        '456 Business Ave, Office Complex, State 54321',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
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

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Methods',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Add Card'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Iconsax.card, color: Colors.white),
                      ),
                      title: Text('Visa •••• 1234'),
                      subtitle: Text('Expires 12/27'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Iconsax.card, color: Colors.white),
                      ),
                      title: Text('Mastercard •••• 5678'),
                      subtitle: Text('Expires 08/26'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
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

  void _showFavorites(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorites',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final favorites = [
                    {
                      'name': 'Blue Denim Jacket',
                      'price': '89.99',
                      'image':
                          'https://images.unsplash.com/photo-1544966503-7cc5ac882d5f?w=400',
                    },
                    {
                      'name': 'White Cotton T-Shirt',
                      'price': '29.99',
                      'image':
                          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
                    },
                    {
                      'name': 'Black Leather Shoes',
                      'price': '129.99',
                      'image':
                          'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
                    },
                    {
                      'name': 'Summer Dress',
                      'price': '79.99',
                      'image':
                          'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
                    },
                  ];
                  final item = favorites[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(item['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\$${item['price']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              title: Text(languageProvider.isArabic ? 'الملف الشخصي' : 'Profile'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Profile Header
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColor.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.user,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 16),

                              // User Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        languageProvider.isArabic ? 'أحمد علي' : 'John Doe',
                                        style: Theme.of(context).textTheme.titleLarge
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Flexible(
                                      child: Text(
                                        languageProvider.isArabic ? 'ahmed.ali@example.com' : 'john.doe@example.com',
                                        style: Theme.of(context).textTheme.bodyMedium
                                            ?.copyWith(color: Colors.grey[600]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        languageProvider.isArabic ? 'عضو مميز' : 'Premium Member',
                                        style: Theme.of(context).textTheme.bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Edit button
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        languageProvider.isArabic 
                                            ? 'ميزة تعديل الملف الشخصي قريباً!' 
                                            : 'Edit profile feature coming soon!',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit),
                                style: IconButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Menu Items with translations
                      Column(
                        children: [
                          ProfileMenuItem(
                            icon: Iconsax.receipt_item,
                            title: languageProvider.isArabic ? 'تاريخ الطلبات' : 'Order History',
                            subtitle: languageProvider.isArabic ? 'عرض طلباتك السابقة' : 'View your past orders',
                            onTap: () => _showOrderHistory(context),
                          ),
                          ProfileMenuItem(
                            icon: Iconsax.location,
                            title: languageProvider.isArabic ? 'العناوين' : 'Addresses',
                            subtitle: languageProvider.isArabic ? 'إدارة عناوين الشحن' : 'Manage your shipping addresses',
                            onTap: () => _showAddresses(context),
                          ),
                          ProfileMenuItem(
                            icon: Iconsax.card,
                            title: languageProvider.isArabic ? 'طرق الدفع' : 'Payment Methods',
                            subtitle: languageProvider.isArabic ? 'إدارة خيارات الدفع' : 'Manage your payment options',
                            onTap: () => _showPaymentMethods(context),
                          ),
                          ProfileMenuItem(
                            icon: Iconsax.heart,
                            title: languageProvider.isArabic ? 'المفضلة' : 'Favorites',
                            subtitle: languageProvider.isArabic ? 'المنتجات المفضلة لديك' : 'Your liked products',
                            onTap: () => _showFavorites(context),
                          ),

                          const SizedBox(height: 12),

                          // Settings Section
                          Card(
                            child: Column(
                              children: [
                                // Dark Mode Toggle
                                Consumer<ThemeProvider>(
                                  builder: (context, themeProvider, child) {
                                    return ListTile(
                                      leading: Icon(
                                        themeProvider.isDarkMode
                                            ? Iconsax.moon
                                            : Iconsax.sun_1,
                                      ),
                                      title: Text(languageProvider.isArabic ? 'الوضع المظلم' : 'Dark Mode'),
                                      subtitle: Text(
                                        languageProvider.isArabic 
                                            ? 'التبديل بين الوضع الفاتح والمظلم' 
                                            : 'Switch between light and dark theme',
                                      ),
                                      trailing: Switch(
                                        value: themeProvider.isDarkMode,
                                        onChanged: (value) {
                                          themeProvider.toggleTheme();
                                        },
                                        activeColor: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  },
                                ),

                                const Divider(height: 1),

                                // Notifications
                                ListTile(
                                  leading: Icon(Iconsax.notification),
                                  title: Text(languageProvider.isArabic ? 'الإشعارات' : 'Notifications'),
                                  subtitle: Text(
                                    languageProvider.isArabic 
                                        ? 'إدارة تفضيلات الإشعارات' 
                                        : 'Manage your notification preferences',
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                  onTap: () {
                                    _showNotificationSettings(context);
                                  },
                                ),

                                const Divider(height: 1),

                                // Language
                                ListTile(
                                  leading: Icon(Iconsax.global),
                                  title: Text(languageProvider.isArabic ? 'اللغة' : 'Language'),
                                  subtitle: Text(languageProvider.isArabic ? 'العربية' : 'English'),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                  onTap: () {
                                    _showLanguageSettings(context);
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Support Section
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Iconsax.message_question),
                                  title: Text(languageProvider.isArabic ? 'المساعدة والدعم' : 'Help & Support'),
                                  subtitle: Text(
                                    languageProvider.isArabic 
                                        ? 'احصل على المساعدة لحسابك' 
                                        : 'Get help with your account',
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                  onTap: () {
                                    _showHelpSupport(context);
                                  },
                                ),

                                const Divider(height: 1),

                                ListTile(
                                  leading: Icon(Iconsax.info_circle),
                                  title: Text(languageProvider.isArabic ? 'حول التطبيق' : 'About'),
                                  subtitle: Text(
                                    languageProvider.isArabic 
                                        ? 'تعرف على المزيد حول كلوثي' 
                                        : 'Learn more about Clothy',
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                  onTap: () {
                                    showAboutDialog(
                                      context: context,
                                      applicationName: languageProvider.isArabic ? 'كلوثي' : 'Clothy',
                                      applicationVersion: '1.0.0',
                                      applicationIcon: Icon(
                                        Iconsax.shopping_bag,
                                        size: 48,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      children: [
                                        Text(
                                          languageProvider.isArabic 
                                              ? 'تطبيق تسوق ملابس عصري مبني باستخدام Flutter.' 
                                              : 'A modern clothing shopping app built with Flutter.',
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Logout Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton.icon(
                              onPressed: _showLogoutDialog,
                              icon: Icon(Iconsax.logout, color: Colors.red),
                              label: Text(
                                languageProvider.isArabic ? 'تسجيل الخروج' : 'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Settings',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text('Push Notifications'),
              subtitle: Text('Receive notifications on your device'),
              value: true,
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
            ),
            SwitchListTile(
              title: Text('Order Updates'),
              subtitle: Text('Get notified about order status'),
              value: true,
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
            ),
            SwitchListTile(
              title: Text('Promotions'),
              subtitle: Text('Receive promotional offers'),
              value: false,
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
            ),
            SwitchListTile(
              title: Text('Email Notifications'),
              subtitle: Text('Receive emails about your account'),
              value: true,
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languageProvider.isArabic ? 'اختر اللغة' : 'Select Language',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text('English'),
                trailing: languageProvider.currentLocale.languageCode == 'en'
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  languageProvider.setLocale(const Locale('en'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Language changed to English')),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text('العربية'),
                trailing: languageProvider.currentLocale.languageCode == 'ar'
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  languageProvider.setLocale(const Locale('ar'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تغيير اللغة إلى العربية')),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Text('🇪🇸', style: TextStyle(fontSize: 24)),
                title: Text('Español'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Iconsax.message_question,
                          color: Colors.white,
                        ),
                      ),
                      title: Text('FAQ'),
                      subtitle: Text('Frequently asked questions'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Iconsax.message, color: Colors.white),
                      ),
                      title: Text('Live Chat'),
                      subtitle: Text('Chat with our support team'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Iconsax.call, color: Colors.white),
                      ),
                      title: Text('Call Support'),
                      subtitle: Text('+1 (555) 123-4567'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(Iconsax.sms, color: Colors.white),
                      ),
                      title: Text('Email Support'),
                      subtitle: Text('support@clothy.com'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Icon(Iconsax.document_text, color: Colors.white),
                      ),
                      title: Text('Terms of Service'),
                      subtitle: Text('Read our terms and conditions'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(Iconsax.security_safe, color: Colors.white),
                      ),
                      title: Text('Privacy Policy'),
                      subtitle: Text('Learn about our privacy practices'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
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

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
