class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final String icon;
  final String image;
  final String colorHex;

  Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.image,
    required this.colorHex,
  });
}

// Sample categories data
final List<Category> sampleCategories = [
  Category(
    id: 'men',
    nameEn: 'Men',
    nameAr: 'رجال',
    icon: 'men',
    image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    colorHex: '#2196F3',
  ),
  Category(
    id: 'women',
    nameEn: 'Women',
    nameAr: 'نساء',
    icon: 'women',
    image: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
    colorHex: '#E91E63',
  ),
  Category(
    id: 'kids',
    nameEn: 'Kids',
    nameAr: 'أطفال',
    icon: 'kids',
    image: 'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=150',
    colorHex: '#FF9800',
  ),
  Category(
    id: 'accessories',
    nameEn: 'Accessories',
    nameAr: 'إكسسوارات',
    icon: 'accessories',
    image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=150',
    colorHex: '#9C27B0',
  ),
  Category(
    id: 'shoes',
    nameEn: 'Shoes',
    nameAr: 'أحذية',
    icon: 'shoes',
    image: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=150',
    colorHex: '#795548',
  ),
  Category(
    id: 'bags',
    nameEn: 'Bags',
    nameAr: 'حقائب',
    icon: 'bags',
    image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=150',
    colorHex: '#607D8B',
  ),
];
