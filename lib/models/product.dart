import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> availableSizes;
  final List<Color> availableColors;
  final String category;
  final double rating;
  final int reviewCount;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.availableSizes,
    required this.availableColors,
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFavorite = false,
  });
}

// Sample products for demonstration
List<Product> sampleProducts = [
  Product(
    id: '1',
    title: 'Summer Casual Dress',
    description:
        'Comfortable and stylish casual dress perfect for summer outings. Made from breathable fabric with a flattering fit.',
    price: 89.99,
    imageUrl:
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [Colors.blue, Colors.red, Colors.green, Colors.black],
    category: 'Dresses',
    rating: 4.5,
    reviewCount: 125,
  ),
  Product(
    id: '2',
    title: 'Classic Denim Jacket',
    description:
        'Timeless denim jacket that pairs well with any outfit. Durable and comfortable for everyday wear.',
    price: 129.99,
    imageUrl: 'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=400',
    availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
    availableColors: [Colors.blue, Colors.black, Colors.grey],
    category: 'Jackets',
    rating: 4.8,
    reviewCount: 89,
  ),
  Product(
    id: '3',
    title: 'Cotton T-Shirt',
    description:
        'Soft and comfortable cotton t-shirt. Perfect for casual wear and layering.',
    price: 29.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
    availableColors: [
      Colors.white,
      Colors.black,
      Colors.grey,
      const Color(0xFF1A237E),
    ],
    category: 'T-Shirts',
    rating: 4.3,
    reviewCount: 203,
  ),
  Product(
    id: '4',
    title: 'Elegant Evening Gown',
    description:
        'Stunning evening gown perfect for special occasions. Elegant design with premium quality fabric.',
    price: 299.99,
    imageUrl:
        'https://images.unsplash.com/photo-1566479179817-c1c1e0a8d20?w=400',
    availableSizes: ['S', 'M', 'L'],
    availableColors: [
      Colors.black,
      const Color(0xFF1A237E),
      const Color(0xFF880E4F),
    ],
    category: 'Dresses',
    rating: 4.9,
    reviewCount: 45,
  ),
  Product(
    id: '5',
    title: 'Casual Hoodie',
    description:
        'Warm and comfortable hoodie perfect for cold weather. Made from high-quality cotton blend.',
    price: 79.99,
    imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
    availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
    availableColors: [
      Colors.grey,
      Colors.black,
      const Color(0xFF1A237E),
      Colors.green,
    ],
    category: 'Hoodies',
    rating: 4.6,
    reviewCount: 167,
  ),
  Product(
    id: '6',
    title: 'Slim Fit Jeans',
    description:
        'Modern slim fit jeans with stretch comfort. Perfect for both casual and semi-formal occasions.',
    price: 99.99,
    imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400',
    availableSizes: ['28', '30', '32', '34', '36'],
    availableColors: [Colors.blue, Colors.black, Colors.grey],
    category: 'Jeans',
    rating: 4.4,
    reviewCount: 98,
  ),
];
