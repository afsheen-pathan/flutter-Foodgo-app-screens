class AppImages {
  static const String image1  = 'assets/images/image1.png';
  static const String image2  = 'assets/images/image2.png';
  static const String image3  = 'assets/images/image3.png';
  static const String image4  = 'assets/images/image4.png';
  static const String image5  = 'assets/images/image5.png';
  static const String image6  = 'assets/images/image6.png';
  static const String image8  = 'assets/images/image8.png';
  static const String image9  = 'assets/images/image9.png';
  static const String image10 = 'assets/images/image10.png';
  static const String image11 = 'assets/images/image11.png';
  static const String image12 = 'assets/images/image12.png';
  static const String image13 = 'assets/images/image13.png';
  static const String image14 = 'assets/images/image14.png';
  static const String image141 = 'assets/images/image14_1.png';
}

class FoodItem {
  final String id;
  final String name;
  final String subtitle;
  final double rating;
  final int deliveryMins;
  final double price;
  final String gridImagePath;
  final String detailImagePath;
  final String description;
  bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.deliveryMins,
    required this.price,
    required this.gridImagePath,
    required this.detailImagePath,
    required this.description,
    this.isFavorite = false,
  });
}

final List<FoodItem> sampleFoodItems = [
  FoodItem(
    id: '1',
    name: 'Cheeseburger',
    subtitle: "Wendy's Burger",
    rating: 4.9,
    deliveryMins: 26,
    price: 8.24,
    gridImagePath: AppImages.image6,
    detailImagePath: AppImages.image9,
    description:
    "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
  ),
  FoodItem(
    id: '2',
    name: 'Hamburger',
    subtitle: 'Veggie Burger',
    rating: 4.8,
    deliveryMins: 14,
    price: 9.99,
    gridImagePath: AppImages.image5,
    detailImagePath: AppImages.image10,
    description:
    'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
  ),
  FoodItem(
    id: '3',
    name: 'Hamburger',
    subtitle: 'Chicken Burger',
    rating: 4.6,
    deliveryMins: 42,
    price: 12.48,
    gridImagePath: AppImages.image4,
    detailImagePath: AppImages.image11,
    description:
    'Our chicken burger is a delicious and healthier alternative to traditional beef burgers, perfect for those looking for a lighter meal option. Try it today and experience the mouth-watering flavors!',
  ),
  FoodItem(
    id: '4',
    name: 'Hamburger',
    subtitle: 'Fried Chicken Burger',
    rating: 4.5,
    deliveryMins: 14,
    price: 26.99,
    gridImagePath: AppImages.image3,
    detailImagePath: AppImages.image12,
    description:
    'Indulge in our crispy and savory Fried Chicken Burger, made with a juicy chicken patty, hand-breaded and deep-fried to perfection, served on a warm bun with lettuce, tomato, and a creamy sauce.',
  ),
];
