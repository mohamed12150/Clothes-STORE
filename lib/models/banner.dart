class Banner {
  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final String image;
  final String? linkTo;

  Banner({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.image,
    this.linkTo,
  });
}

// Sample banners data
final List<Banner> sampleBanners = [
  Banner(
    id: '1',
    titleEn: 'Summer Sale',
    titleAr: 'تخفيضات الصيف',
    subtitleEn: 'Up to 70% off',
    subtitleAr: 'خصم يصل إلى 70%',
    image: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
    linkTo: '/category/sale',
  ),
  Banner(
    id: '2',
    titleEn: 'New Collection',
    titleAr: 'مجموعة جديدة',
    subtitleEn: 'Latest fashion trends',
    subtitleAr: 'أحدث صيحات الموضة',
    image: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800',
    linkTo: '/category/new',
  ),
  Banner(
    id: '3',
    titleEn: 'Free Shipping',
    titleAr: 'شحن مجاني',
    subtitleEn: 'On orders over \$50',
    subtitleAr: 'على الطلبات فوق 50 دولار',
    image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=800',
    linkTo: '/shipping',
  ),
];
