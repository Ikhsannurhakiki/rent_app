import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';
import 'package:rent_app/presentation/screens/map_screens.dart';
import 'package:rent_app/presentation/widgets/date_range_picker.dart';
import 'package:rent_app/presentation/widgets/location_picker_card.dart';

import '../../common/distance_type_enum.dart';
import '../../common/state_enum.dart';
import '../provider/map_provider.dart';
import '../provider/unit_notifier.dart';
import '../widgets/subHeading.dart';

class BookingScreen extends StatefulWidget {
  final int id;
  final int typeId;

  BookingScreen({super.key, required this.id, required this.typeId});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _startDateTime;
  DateTime? _endDateTime;

  LatLng? _currentLatLng;
  final Location _locationService = Location();
  Placemark? _placemark;
  Placemark? _placemarkOffice;

  double pickupCost = 0;
  double returnCost = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UnitNotifier>(context, listen: false).fetchDetail(widget.id);
      _initData();
    });
  }

  Future<void> _initData() async {
    final provider = context.read<BookNotifier>();
    provider.resetRange();
    _officeLocation();
    _initLocation();
  }

  Future<void> _officeLocation() async {
    final dataProvider = context.read<MapProvider>();
    final unitProvider = context.read<UnitNotifier>();
    LatLng? latLng = dataProvider.latLng;
    Placemark? placemark = dataProvider.placemarkCurrent;
    // Get placemark from coordinates
    try {
      final placemarks = await placemarkFromCoordinates(
        unitProvider.detailUnit.ownerLatitude,
        unitProvider.detailUnit.ownerLongitude,
      );
      if (placemarks.isNotEmpty) {
        placemark = placemarks.first;
        dataProvider.setPlacemarkOffice(placemark);
      }
    } catch (e) {
      debugPrint("Placemark error: $e");
      print(e.toString());
    }
    setState(() {
      _placemarkOffice = placemark;
    });
  }

  Future<void> _initLocation() async {
    final dataProvider = context.read<MapProvider>();
    LatLng? latLng = dataProvider.latLng;
    Placemark? placemark = dataProvider.placemarkCurrent;
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) return;
    }

    // Check permission
    PermissionStatus permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get current location
    final locationData = await _locationService.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    // if (lat == null || lng == null) return;
    latLng = LatLng(lat!, lng!);
    // Get placemark from coordinates
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      print(placemarks);
      if (placemarks.isNotEmpty) {
        placemark = placemarks.first;
        dataProvider.setPlacemarkCurrent(placemark);
        print(placemark);
      }
    } catch (e) {
      // Handle geocoding errors
      debugPrint("Placemark error: $e");
      print(e.toString());
    }

    // Update state
    setState(() {
      _currentLatLng = latLng!;
      _placemark = placemark;
    });
    await dataProvider.getDistance(
      -6.200000,
      106.816666, // start
      -6.914744,
      107.609810, // end
      "eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjA1NjgyMjg3ZGY3MDQyNjRhMzQzOTY2N2M1NjU2YThlIiwiaCI6Im11cm11cjY0In0=",
      DistanceType.current,
    );

  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###", "id_ID");
    final provider = context.watch<BookNotifier>();
    final mapProvider = context.watch<MapProvider>();
    int dayCount = 0;

    String? displayText;
    if (provider.startDate != null && provider.endDate == null) {
      dayCount = 1;
      displayText = "$dayCount day";
    } else if (provider.startDate != null && provider.endDate != null) {
      final start = provider.startDate!.toLocal();
      final end = provider.endDate!.toLocal();
      dayCount = end.difference(start).inDays + 1;
      displayText = "$dayCount days";
    } else {
      dayCount = 0;
      displayText = "";
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Ride')),
      body: Consumer<UnitNotifier>(
        builder: (context, provider, child) {
          if (provider.detailState == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.detailState == RequestState.Loaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SubHeading(
                                  title: 'Unit Details:',
                                  icon: Icons.navigate_next_rounded,
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Image.asset("assets/icons/auto.png"),
                                  title: Text("Toyota Avanza 2023"),
                                  subtitle: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("BM 1312 BT"),
                                      Text(
                                        "500.000/day",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 480,
                          child: Center(
                            child: Card(elevation: 1, child: DateRangePicker()),
                          ),
                        ),
                        LocationPicker(isPickup: true),
                        LocationPicker(isPickup: false),
                        // Card(
                        //   elevation: 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Row(
                        //           mainAxisSize: MainAxisSize.max,
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             SubHeading(
                        //               title: 'Pickup Location:',
                        //               icon: null,
                        //               onTap: () {},
                        //             ),
                        //             !isExpandedPickUp
                        //                 ? TextButton(
                        //                     onPressed: () =>
                        //                         _toggleExpand(true),
                        //                     child: Text(
                        //                       'Change',
                        //                       style: TextStyle(
                        //                         color: Theme.of(
                        //                           context,
                        //                         ).colorScheme.primary,
                        //                       ),
                        //                     ),
                        //                   )
                        //                 : SizedBox.shrink(),
                        //           ],
                        //         ),
                        //         AnimatedSize(
                        //           duration: const Duration(milliseconds: 800),
                        //           curve: Curves.easeInOut,
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Collapsed view
                        //               if (_showCollapsedPickUp)
                        //                 AnimatedOpacity(
                        //                   opacity: isExpandedPickUp ? 0.0 : 1.0,
                        //                   duration: const Duration(
                        //                     milliseconds: 500,
                        //                   ),
                        //                   child: ListTile(
                        //                     title: Text(
                        //                       _selectedPickUp == 'office'
                        //                           ? provider.detailUnit.ownerDetails!.businessName
                        //                           : _selectedPickUp == 'current'
                        //                           ? 'Current Location'
                        //                           : _selectedPickUp == 'pick'
                        //                           ? 'Pick Location'
                        //                           : 'Unknown',
                        //                     ),
                        //                     leading: Radio<String>(
                        //                       value: _selectedPickUp,
                        //                       groupValue: _selectedPickUp,
                        //                       onChanged: null,
                        //                     ),
                        //                     subtitle:
                        //                         _selectedPickUp == 'office'
                        //                         ? Text("Pekanbaru")
                        //                         : Consumer<MapProvider>(
                        //                             builder: (context, provider, _) {
                        //                               final info =
                        //                                   _selectedPickUp ==
                        //                                       "pick"
                        //                                   ? provider
                        //                                         .placemarkPickUp
                        //                                   : _selectedPickUp ==
                        //                                         "current"
                        //                                   ? provider
                        //                                         .placemarkCurrent
                        //                                   : null;
                        //                               return info != null
                        //                                   ? Text(
                        //                                       maxLines: 5,
                        //                                       overflow:
                        //                                           TextOverflow
                        //                                               .ellipsis,
                        //                                       "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                        //                                     )
                        //                                   : Container();
                        //                             },
                        //                           ),
                        //                     onTap: () {
                        //                       setState(() {
                        //                         _selectedPickUp;
                        //                         _toggleExpand(true);
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //
                        //               // Expanded view
                        //               if (_showExpandedPickUp)
                        //                 AnimatedOpacity(
                        //                   opacity: isExpandedPickUp ? 1.0 : 0.0,
                        //                   duration: const Duration(
                        //                     milliseconds: 500,
                        //                   ),
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.center,
                        //                     children: [
                        //                       ListTile(
                        //                         title: Text(provider.detailUnit.ownerDetails!.businessName),
                        //                         subtitle: Text("Pekanbaru"),
                        //                         leading: Radio<String>(
                        //                           value: 'office',
                        //                           groupValue: _selectedPickUp,
                        //                           onChanged: (value) {
                        //                             setState(() {
                        //                               pickupCost = 0;
                        //                               _selectedPickUp = value!;
                        //                             });
                        //                           },
                        //                         ),
                        //                         onTap: () {
                        //                           setState(() {
                        //                             pickupCost = 0;
                        //                             _selectedPickUp = 'office';
                        //                             _toggleExpand(true);
                        //                           });
                        //                         },
                        //                       ),
                        //                       Consumer<MapProvider>(
                        //                         builder: (context, provider, _) {
                        //                           final info =
                        //                               provider.placemarkCurrent;
                        //                           return ListTile(
                        //                             title: Text(
                        //                               'Current Location',
                        //                             ),
                        //                             subtitle: info != null
                        //                                 ? Text(
                        //                                     "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                        //                                     maxLines: 5,
                        //                                     overflow:
                        //                                         TextOverflow
                        //                                             .ellipsis,
                        //                                   )
                        //                                 : const Text(
                        //                                     "No location selected.",
                        //                                   ),
                        //                             leading: Radio<String>(
                        //                               value: 'current',
                        //                               groupValue:
                        //                                   _selectedPickUp,
                        //                               onChanged: (value) {
                        //                                 setState(() {
                        //                                   pickupCost = 25000;
                        //                                   _selectedPickUp =
                        //                                       value!;
                        //                                 });
                        //                                 if (info == null) {
                        //                                   Navigator.push(
                        //                                     context,
                        //                                     MaterialPageRoute(
                        //                                       builder: (context) =>
                        //                                           const MapScreen(
                        //                                             isPick:
                        //                                                 true,
                        //                                           ),
                        //                                     ),
                        //                                   );
                        //                                 }
                        //                               },
                        //                             ),
                        //                             onTap: () {
                        //                               setState(() {
                        //                                 pickupCost = 25000;
                        //                                 _selectedPickUp =
                        //                                     'current';
                        //                               });
                        //                               if (info == null) {
                        //                                 Navigator.push(
                        //                                   context,
                        //                                   MaterialPageRoute(
                        //                                     builder: (context) =>
                        //                                         const MapScreen(
                        //                                           isPick: true,
                        //                                         ),
                        //                                   ),
                        //                                 );
                        //                               } else {
                        //                                 _toggleExpand(true);
                        //                               }
                        //                             },
                        //                           );
                        //                         },
                        //                       ),
                        //                       Consumer<MapProvider>(
                        //                         builder: (context, provider, _) {
                        //                           final info =
                        //                               provider.placemarkPickUp;
                        //                           return Row(
                        //                             children: [
                        //                               Expanded(
                        //                                 child: ListTile(
                        //                                   title: const Text(
                        //                                     'Pick Location',
                        //                                   ),
                        //                                   subtitle: info != null
                        //                                       ? Text(
                        //                                           "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                        //                                           maxLines: 5,
                        //                                           overflow:
                        //                                               TextOverflow
                        //                                                   .ellipsis,
                        //                                         )
                        //                                       : const Text(
                        //                                           "No location selected.",
                        //                                         ),
                        //                                   leading: Radio<String>(
                        //                                     value: 'pick',
                        //                                     groupValue:
                        //                                         _selectedPickUp,
                        //                                     onChanged: (value) {
                        //                                       setState(() {
                        //                                         pickupCost =
                        //                                             50000;
                        //                                         _selectedPickUp =
                        //                                             value!;
                        //                                       });
                        //                                       info != null
                        //                                           ? null
                        //                                           : Navigator.push(
                        //                                               context,
                        //                                               MaterialPageRoute(
                        //                                                 builder:
                        //                                                     (
                        //                                                       context,
                        //                                                     ) => const MapScreen(
                        //                                                       isPick: true,
                        //                                                     ),
                        //                                               ),
                        //                                             );
                        //                                     },
                        //                                   ),
                        //                                   onTap: () {
                        //                                     setState(() {
                        //                                       pickupCost =
                        //                                           50000;
                        //                                       _selectedPickUp =
                        //                                           'pick';
                        //                                     });
                        //                                     info == null
                        //                                         ? Navigator.push(
                        //                                             context,
                        //                                             MaterialPageRoute(
                        //                                               builder:
                        //                                                   (
                        //                                                     context,
                        //                                                   ) => const MapScreen(
                        //                                                     isPick:
                        //                                                         true,
                        //                                                   ),
                        //                                             ),
                        //                                           )
                        //                                         : setState(() {
                        //                                             _selectedPickUp =
                        //                                                 'pick';
                        //                                             _toggleExpand(
                        //                                               true,
                        //                                             );
                        //                                           });
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               IconButton(
                        //                                 icon: const Icon(
                        //                                   Icons.edit,
                        //                                 ),
                        //                                 onPressed: () {
                        //                                   Navigator.push(
                        //                                     context,
                        //                                     MaterialPageRoute(
                        //                                       builder: (context) =>
                        //                                           const MapScreen(
                        //                                             isPick:
                        //                                                 true,
                        //                                           ),
                        //                                     ),
                        //                                   );
                        //                                 },
                        //                               ),
                        //                             ],
                        //                           );
                        //                         },
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SubHeading(
                            title: 'Payment Method:',
                            icon: Icons.expand_more,
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => DateRangePickerScreen()));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.money_outlined),
                            title: Text("Cash"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<BookNotifier>(
                    builder: (context, provider, child) {
                      return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SubHeading(
                                title: 'Summary',
                                icon: null,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dayCount == 0
                                            ? "Unit Costs"
                                            : "Unit Costs (${displayText ?? ""})",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        dayCount == 0
                                            ? "-"
                                            : "Rp. ${formatter.format(500000 * dayCount)}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pickup Costs",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Rp. ${formatter.format(pickupCost)}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Return Costs",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Rp. ${formatter.format(50000)}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Rp. ${formatter.format(1100000)}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                ],
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookingScreen(id: widget.id, typeId: widget.typeId),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shadowColor: Colors.blue,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
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
  }
}
