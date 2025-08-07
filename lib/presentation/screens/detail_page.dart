import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/data/entities/Unit.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../data/models/specific_detail_entity.dart';
import '../widgets/rent_item_card.dart';
import '../widgets/subHeading.dart';

class UnitDetailPage extends StatefulWidget {
  final int id;
  final int typeId;

  UnitDetailPage({required this.id, required this.typeId});

  @override
  _UnitDetailPageState createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends State<UnitDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      print(widget.id);
      Provider.of<UnitNotifier>(context, listen: false).fetchDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unit Details")),
      body: Consumer<UnitNotifier>(
        builder: (context, provider, child) {
          if (provider.detailState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.detailState == RequestState.Loaded) {
            final unit = provider.detailUnit;
            return SafeArea(child: DetailContent(unit));
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final UnitDetailEntity unit;

  DetailContent(this.unit);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  int _currentIndex = 0;
  bool isExpanded = false;
  bool _showCollapsed = true;
  bool _showExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });

    if (isExpanded) {
      // Show expanded immediately
      setState(() => _showCollapsed = false);
      setState(() => _showExpanded = true);
      // Hide collapsed after fade duration
      // Future.delayed(const Duration(milliseconds: 500), () {
      //   if (mounted && isExpanded) {
      //     setState(() => _showCollapsed = false);
      //   }
      // });
    } else {
      // Show collapsed immediately
      setState(() => _showExpanded = false);

      setState(() => _showCollapsed = true);
      // Hide expanded after fade duration
      // Future.delayed(const Duration(milliseconds: 500), () {
      //   if (mounted && !isExpanded) {
      //     setState(() => _showExpanded = false);
      //   }
      // });
    }
  }

  Widget _buildCarDetails(CarDetailEntity car) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Collapsed view
              if (_showCollapsed)
                AnimatedOpacity(
                  opacity: isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconColumn(
                        'assets/icons/auto.png',
                        "${car.make} ${car.model} ${car.year}",
                        context,
                      ),
                      _buildIconColumn(
                        'assets/icons/engine.png',
                        car.engine,
                        context,
                      ),
                    ],
                  ),
                ),

              // Expanded view
              if (_showExpanded)
                AnimatedOpacity(
                  opacity: isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/auto.png',
                            "${car.make} ${car.model} ${car.year}",
                            context,
                          ),
                          _buildIconColumn(
                            'assets/icons/engine.png',
                            car.engine,
                            context,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/plate.png',
                            car.licensePlate,
                            context,
                          ),
                          _buildIconColumn(
                            'assets/icons/transmission.png',
                            "${car.transmission}",
                            context,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/seat.png',
                            "${car.passengerCapacity} seater",
                            context,
                          ),
                          _buildIconColumn(
                            'assets/icons/gasoline.png',
                            car.fuelType,
                            context,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/ink.png',
                            car.color,
                            context,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconColumn(String iconPath, String label, BuildContext context) {
    return SizedBox(
      width: 170,
      height: 150,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, width: 40, height: 40),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMotorcycleDetails(MotorcycleDetailEntity motorcycle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Collapsed view
              if (_showCollapsed)
                AnimatedOpacity(
                  opacity: isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconColumn(
                        'assets/icons/motorcycle.png',
                        "${motorcycle.make} ${motorcycle.model} ${motorcycle.year}",
                        context,
                      ),
                      _buildIconColumn(
                        'assets/icons/engine.png',
                        "${motorcycle.engineCc} CC",
                        context,
                      ),
                    ],
                  ),
                ),

              // Expanded view
              if (_showExpanded)
                AnimatedOpacity(
                  opacity: isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/motorcycle.png',
                            "${motorcycle.make} ${motorcycle.model} ${motorcycle.year}",
                            context,
                          ),
                          _buildIconColumn(
                            'assets/icons/engine.png',
                            "${motorcycle.engineCc} CC",
                            context,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/plate.png',
                            motorcycle.licensePlate,
                            context,
                          ),
                          _buildIconColumn(
                            'assets/icons/transmission.png',
                            "${motorcycle.transmission}",
                            context,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconColumn(
                            'assets/icons/ink.png',
                            motorcycle.color,
                            context,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
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
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: SubHeading(
            title: 'Specification:',
            icon: isExpanded ? Icons.expand_more : Icons.expand_less,
            onTap: _toggleExpand,
          ),
        ),
        const SizedBox(height: 8),
        specificDetailContent, // This is the single widget determined above
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 350.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  // Animation duration
                  autoPlayCurve: Curves.fastOutSlowIn,
                  // Animation curve
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                // Map your list of UnitImageEntity (or UnitImageModel) to Image.network widgets
                items: widget.unit.images.map<Widget>((UnitImageEntity image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        // Use Image.network for web URLs
                        child: Image.network(
                          image.imageUrl,
                          // Access the imageUrl from your UnitImageEntity
                          width: double.infinity,
                          // Take full width of the container
                          fit: BoxFit.fitHeight,
                          // Cover the entire space, cropping if necessary
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image_rounded,
                                color: Colors.grey,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: 1.0, // you can change this to 0.0 to hide
                    curve: Curves.easeInOut,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black, // semi-transparent background
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.unit.images.asMap().entries.map((
                          entry,
                        ) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: _currentIndex == entry.key ? 10.0 : 4.0,
                            height: _currentIndex == entry.key ? 10.0 : 4.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: Text(
                                      widget.unit.name,
                                      style: kHeading5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: Text(
                                      "${widget.unit.currency}  ${widget.unit.currency == "IDR" ? widget.unit.dailyRate.toStringAsFixed(0) : widget.unit.dailyRate.toStringAsFixed(2)} / day",
                                      style: kDailyRate,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Status : ',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        widget.unit.availabilityStatus ==
                                                "available"
                                            ? Lottie.asset(
                                                'assets/lottie/success.json',
                                                width: 20,
                                                height: 20,
                                                repeat: true,
                                                reverse: true,
                                                animate: true,
                                              )
                                            : Lottie.asset(
                                                'assets/lottie/failed.json',
                                                width: 20,
                                                height: 20,
                                                repeat: true,
                                                reverse: true,
                                                animate: true,
                                              ),
                                        Text(
                                          " ${widget.unit.availabilityStatus}",
                                          style: TextStyle(
                                            color:
                                                widget
                                                        .unit
                                                        .availabilityStatus ==
                                                    "available"
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (widget.unit.specificDetails != null) ...[
                                    _buildSpecificDetailsSection(
                                      context,
                                      widget.unit,
                                    ),
                                  ],

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         RatingBarIndicator(
                                  //           rating: unit.r.voteAverage / 2,
                                  //           itemCount: 5,
                                  //           itemBuilder: (context, index) => Icon(
                                  //             Icons.star,
                                  //             color: kMikadoYellow,
                                  //           ),
                                  //           itemSize: 24,
                                  //         ),
                                  //         SizedBox(width: 8,),
                                  //         Text('${double.parse((movie.voteAverage / 2).toStringAsFixed(2))}', style: TextStyle(color: kMikadoYellow, fontSize: 14, fontWeight: FontWeight.w500) ),
                                  //       ],
                                  //     ),
                                  //
                                  //     FilledButton(
                                  //       onPressed: () async {
                                  //         if (!isAddedWatchlist) {
                                  //           await Provider.of<MovieDetailNotifier>(
                                  //               context,
                                  //               listen: false)
                                  //               .addWatchlist(movie);
                                  //         } else {
                                  //           await Provider.of<MovieDetailNotifier>(
                                  //               context,
                                  //               listen: false)
                                  //               .removeFromWatchlist(movie);
                                  //         }
                                  //
                                  //         final message =
                                  //             Provider.of<MovieDetailNotifier>(context,
                                  //                 listen: false)
                                  //                 .watchlistMessage;
                                  //
                                  //         if (message ==
                                  //             MovieDetailNotifier
                                  //                 .watchlistAddSuccessMessage ||
                                  //             message ==
                                  //                 MovieDetailNotifier
                                  //                     .watchlistRemoveSuccessMessage) {
                                  //           ScaffoldMessenger.of(context).showSnackBar(
                                  //               SnackBar(content: Text(message)));
                                  //         } else {
                                  //           showDialog(
                                  //               context: context,
                                  //               builder: (context) {
                                  //                 return AlertDialog(
                                  //                   content: Text(message),
                                  //                 );
                                  //               });
                                  //         }
                                  //       },
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           isAddedWatchlist
                                  //               ? Icon(Icons.check)
                                  //               : Icon(Icons.add),
                                  //           Text('Watchlist'),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: Text(
                                      'Overview:',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: Text(
                                      widget.unit.description,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 0,
                                    ),
                                    child: SubHeading(
                                      title: 'Recommended for you',
                                      icon: Icons.navigate_next_rounded,
                                      onTap: () {},
                                    ),
                                  ),
                                  Consumer<UnitNotifier>(
                                    builder: (context, data, child) {
                                      print(data.recommendationUnitsState);
                                      if (data.recommendationUnitsState ==
                                          RequestState.Loading) {
                                        return SizedBox(
                                          height: 100,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else if (data
                                              .recommendationUnitsState ==
                                          RequestState.Loaded) {
                                        return SizedBox(
                                          height: 220,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                data.recommendationsUnit.length,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            itemBuilder: (context, index) {
                                              final item = data
                                                  .recommendationsUnit[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                child: RentCard(
                                                  item: item,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            UnitDetailPage(
                                                              id: item.id,
                                                              typeId:
                                                                  item.unitTypeId,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          key: Key('error_message'),
                                          child: SizedBox(
                                            height: 100,
                                            child: Center(
                                              child: Text("Error loading data"),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Theme.of(context).colorScheme.onSecondary,
                              height: 4,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(elevation: 3),
                                child: Icon(
                                  Icons.message_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 4,
                            child: ElevatedButton(
                              onPressed:
                                  widget.unit.availabilityStatus == "available"
                                  ? () {
                                      final bookedDateTime = showRentTimeDialog(
                                        context,
                                      );
                                      if (bookedDateTime != null) {
                                        print("Booked for: $bookedDateTime");
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                shadowColor: Colors.blue,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                              ),
                              child: Text(
                                widget.unit.availabilityStatus == "available"
                                    ? "Request Booking"
                                    : "Not Available",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showRentTimeDialog(BuildContext context) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Select Rent Date & Time'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() => selectedDate = pickedDate);
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      selectedDate == null
                          ? "Choose Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() => selectedTime = pickedTime);
                      }
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      selectedTime == null
                          ? "Choose Time"
                          : selectedTime!.format(context),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null && selectedTime != null) {
                  final bookedDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );
                  Navigator.pop(context, bookedDateTime);
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
