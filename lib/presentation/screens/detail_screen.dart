import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

import '../../common/state_enum.dart';
import '../../data/entities/Unit.dart';
import '../../data/models/specific_detail_entity.dart';
import '../provider/unit_notifier.dart';

class DetailScreen extends StatefulWidget {
  final int unitId;

  const DetailScreen({Key? key, required this.unitId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    final unitId = widget.unitId;
    Future.microtask(() {
      Provider.of<UnitNotifier>(context, listen: false).fetchDetail(unitId);
    });
  }

  // --- Helper functions for rendering specific details (these remain the same) ---
  Widget _buildCarDetails(CarDetailEntity car) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipe: Mobil'),
        Text('Merek: ${car.make}'),
        Text('Model: ${car.model}'),
        Text('Tahun: ${car.year}'),
        Text('Transmisi: ${car.transmission}'),
        Text('Bahan Bakar: ${car.fuelType}'),
        Text('Kapasitas Penumpang: ${car.passengerCapacity}'),
        Text('Plat Nomor: ${car.licensePlate}'),
        Text('Warna: ${car.color}'),
      ],
    );
  }

  Widget _buildMotorcycleDetails(MotorcycleDetailEntity motorcycle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipe: Motor'),
        Text('Merek: ${motorcycle.make}'),
        Text('Model: ${motorcycle.model}'),
        Text('Tahun: ${motorcycle.year}'),
        Text('Mesin (CC): ${motorcycle.engineCc}'),
        Text('Transmisi: ${motorcycle.transmission}'),
        Text('Plat Nomor: ${motorcycle.licensePlate}'),
        Text('Warna: ${motorcycle.color}'),
      ],
    );
  }

  Widget _buildHouseDetails(HouseDetailEntity house) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipe: Rumah'),
        Text('Kamar Tidur: ${house.numBedrooms}'),
        Text('Kamar Mandi: ${house.numBathrooms}'),
        Text('Luas (sqm): ${house.areaSqm}'),
        Text('Jenis Properti: ${house.propertyType}'),
        Text('Alamat Lengkap: ${house.fullAddress}'),
        Text('Kota: ${house.city}'),
        Text('Provinsi: ${house.province}'),
        Text('Kode Pos: ${house.postalCode}'),
        Text('Fasilitas: ${house.amenities ?? 'Tidak ada'}'),
      ],
    );
  }

  // --- NEW HELPER FUNCTION TO BUILD THE ENTIRE SPECIFIC DETAILS SECTION ---
  Widget _buildSpecificDetailsSection(
    BuildContext context,
    UnitDetailEntity unitDetail,
  ) {
    // If specificDetails is null, don't show anything
    if (unitDetail.specificDetails == null) {
      return const SizedBox.shrink();
    }

    // This variable will hold the specific widget for car, motorcycle, or house
    Widget specificDetailContent;

    // Determine which specific detail widget to return
    if (unitDetail.specificDetails is CarDetailEntity) {
      specificDetailContent = _buildCarDetails(
        unitDetail.specificDetails as CarDetailEntity,
      );
    } else if (unitDetail.specificDetails is MotorcycleDetailEntity) {
      specificDetailContent = _buildMotorcycleDetails(
        unitDetail.specificDetails as MotorcycleDetailEntity,
      );
    } else if (unitDetail.specificDetails is HouseDetailEntity) {
      specificDetailContent = _buildHouseDetails(
        unitDetail.specificDetails as HouseDetailEntity,
      );
    } else {
      specificDetailContent = const Text('Tipe detail spesifik tidak dikenal.');
    }

    // Return a Column containing the header and the specific content
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          'Detail Spesifik:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        specificDetailContent, // This is the single widget determined above
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitNotifier>(
      builder: (context, provider, child) {
        if (provider.detailState == RequestState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.detailState == RequestState.Loaded) {
          final unitDetail = provider.detailUnit;
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              title: Image.asset(
                "assets/appbar/appbar.png",
                width: 100,
                height: 60,
                fit: BoxFit.fitWidth,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        // Fixed height for the carousel
                        autoPlay: true,
                        // Images will slide automatically
                        enlargeCenterPage: true,
                        // Make the center image slightly larger
                        viewportFraction: 1,
                        // Show 95% of the current image, with a peek of next/prev
                        aspectRatio: 16 / 9,
                        // Aspect ratio for images
                        autoPlayInterval: const Duration(seconds: 5),
                        // Time between slides
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        // Animation duration
                        autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
                      ),
                      // Map your list of UnitImageEntity (or UnitImageModel) to Image.network widgets
                      items: unitDetail.images.map<Widget>((
                        UnitImageEntity image,
                      ) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                // Optional: Add border or background
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Use Image.network for web URLs
                                child: Image.network(
                                  image.imageUrl,
                                  // Access the imageUrl from your UnitImageEntity
                                  width: double.infinity,
                                  // Take full width of the container
                                  fit: BoxFit.cover,
                                  // Cover the entire space, cropping if necessary
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      unitDetail.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    unitDetail.description != ""
                        ? Text(unitDetail.description)
                        : SizedBox.shrink(),

                    SizedBox(height: 16),

                    if (unitDetail.specificDetails != null) ...[
                      const Divider(),
                      _buildSpecificDetailsSection(context, unitDetail),

                      Row(
                        children: [
                          Icon(Icons.directions_car),
                          SizedBox(width: 8),
                          Text('Type: ${unitDetail.unitType}'),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          SizedBox(width: 8),
                          Text(
                            'Rate: ${unitDetail.currency} ${unitDetail.dailyRate.toStringAsFixed(0)} / day',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 8),
                          Text('Location: ${unitDetail.location}'),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(Icons.check_circle),
                          SizedBox(width: 8),
                          Text('Status: ${unitDetail.availabilityStatus}'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text("Error loading data"),
          );
        }
      },
    );
  }
}
