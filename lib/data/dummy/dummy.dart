class Unit {
  final int id;
  final String name;
  final List<String> images;

  Unit({
    required this.id,
    required this.name,
    required this.images,
  });

  // Metode statis untuk membuat objek Unit dengan data dummy
  static Unit dummy() {
    return Unit(
      id: 1,
      name: 'SUV Nissan X-Trail',
      images: [
        'https://images.unsplash.com/photo-1549447385-4813589b917c?fit=crop&w=1280&q=80',
        'https://images.unsplash.com/photo-1533032549242-b06225575c32?fit=crop&w=1280&q=80',
        'https://images.unsplash.com/photo-1557434551-78c6e0a81119?fit=crop&w=1280&q=80',
        'https://images.unsplash.com/photo-1533032549242-b06225575c32?fit=crop&w=1280&q=80',
      ],
    );
  }
}