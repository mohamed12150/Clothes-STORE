import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/banner.dart' as banner_model;

class ShopProvider extends ChangeNotifier {
  final List<Category> _categories = sampleCategories;
  final List<banner_model.Banner> _banners = banner_model.sampleBanners;
  String _selectedCategoryId = '';
  int _currentBannerIndex = 0;

  List<Category> get categories => _categories;
  List<banner_model.Banner> get banners => _banners;
  String get selectedCategoryId => _selectedCategoryId;
  int get currentBannerIndex => _currentBannerIndex;

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setBannerIndex(int index) {
    _currentBannerIndex = index;
    notifyListeners();
  }

  void nextBanner() {
    _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
    notifyListeners();
  }

  Category? getCategoryById(String id) {
    return _categories.where((category) => category.id == id).firstOrNull;
  }
}
