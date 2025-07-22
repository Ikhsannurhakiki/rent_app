class RentItemEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String pricePerDay;
  final String category;

  const RentItemEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    required this.category,
  });
}
