import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/screens/map_screens.dart';
import 'package:rent_app/presentation/screens/test.dart';

import '../provider/map_provider.dart';
import '../widgets/subHeading.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String _selectedPickUp = 'pick';
  String _selectedReturn = 'office';
  bool isExpandedPickUp = false;
  bool _showCollapsedPickUp = true;
  bool _showExpandedPickUp = false;
  bool isExpandedReturn = false;
  bool _showCollapsedReturn = true;
  bool _showExpandedReturn = false;
  LatLng? _currentLatLng;
  final Location _locationService = Location();
  Placemark? _placemark;


  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final dataProvider = context.read<MapProvider>();
    LatLng? latLng = dataProvider.latLng;
    Placemark? placemark = dataProvider.placemarkCurrent;

    // Only get location if not already set

      // Check service enabled
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
      print("aaaaaaaa");
      print(latLng);
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

      // Save to provider
      dataProvider.setLatLngPickUp(latLng);


    // Update state
    setState(() {
      _currentLatLng = latLng!;
      _placemark = placemark;
    });
  }



  void _toggleExpand(bool isPickUp) {
    setState(() {
      if (isPickUp) {
        isExpandedPickUp = !isExpandedPickUp;
      } else {
        isExpandedReturn = !isExpandedReturn;
      }

      _showExpandedPickUp = isExpandedPickUp;
      _showCollapsedPickUp = !isExpandedPickUp;

      _showExpandedReturn = isExpandedReturn;
      _showCollapsedReturn = !isExpandedReturn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Ride')),
      body: SingleChildScrollView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 500,
                    child: Card(
                      elevation: 1,
                      child: DateRangePickerScreen(),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubHeading(
                                title: 'Pickup Location:',
                                icon: null,
                                onTap: () {},
                              ),
                              !isExpandedPickUp
                                  ? TextButton(
                                      onPressed: () => _toggleExpand(true),
                                      child: Text(
                                        'Change',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Collapsed view
                                if (_showCollapsedPickUp)
                                  AnimatedOpacity(
                                    opacity: isExpandedPickUp ? 0.0 : 1.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: ListTile(
                                      title: Text(
                                        _selectedPickUp == 'office'
                                            ? 'Rent App HQ'
                                            : _selectedPickUp == 'current'
                                            ? 'Current Location'
                                            : _selectedPickUp == 'pick'
                                            ? 'Pick Location'
                                            : 'Unknown',
                                      ),
                                      leading: Radio<String>(
                                        value: _selectedPickUp,
                                        groupValue: _selectedPickUp,
                                        onChanged: null,
                                      ),
                                      subtitle: _selectedPickUp == 'office' ? Text("Pekanbaru"):
                                      Consumer<MapProvider>(
                                              builder: (context, provider, _) {
                                                final info = _selectedPickUp == "pick" ? provider.placemarkPickUp : _selectedPickUp == "current" ? provider.placemarkCurrent : null;
                                                return info != null
                                                    ? Text(
                                                        maxLines: 5,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                  "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                                      )
                                                    : Container();
                                              },
                                            ),
                                      onTap: () {
                                        setState(() {
                                          _selectedPickUp;
                                          _toggleExpand(true);
                                        });
                                      },
                                    ),
                                  ),

                                // Expanded view
                                if (_showExpandedPickUp)
                                  AnimatedOpacity(
                                    opacity: isExpandedPickUp ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          title: Text('Rent App HQ'),
                                          subtitle: Text("Pekanbaru"),
                                          leading: Radio<String>(
                                            value: 'office',
                                            groupValue: _selectedPickUp,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedPickUp = value!;
                                              });
                                            },
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _selectedPickUp = 'office';
                                              _toggleExpand(true);
                                            });
                                          },
                                        ),
                                        Consumer<MapProvider>(
                                          builder: (context, provider, _) {
                                            final info = provider.placemarkCurrent;
                                            return ListTile(
                                              title: Text('Current Location'),
                                              subtitle: info != null
                                                  ? Text(
                                                "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                                  : const Text("No location selected."),
                                              leading: Radio<String>(
                                                value: 'current',
                                                groupValue: _selectedPickUp,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedPickUp = value!;
                                                  });
                                                  if (info == null) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => const MapScreen(isPick: true),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _selectedPickUp = 'current';
                                                });
                                                if (info == null) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const MapScreen(isPick: true),
                                                    ),
                                                  );
                                                } else {
                                                  _toggleExpand(true);
                                                }
                                              },
                                            );
                                          },
                                        ),
                                        Consumer<MapProvider>(
                                          builder: (context, provider, _) {
                                            final info = provider.placemarkPickUp;
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: const Text(
                                                      'Pick Location',
                                                    ),
                                                    subtitle: info != null
                                                        ? Text(
                                                      "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                                            maxLines: 5,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          )
                                                        : const Text(
                                                            "No location selected.",
                                                          ),
                                                    leading: Radio<String>(
                                                      value: 'pick',
                                                      groupValue: _selectedPickUp,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedPickUp =
                                                              value!;
                                                        });
                                                        info != null
                                                            ? null
                                                            : Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      const MapScreen(
                                                                        isPick:
                                                                            true,
                                                                      ),
                                                                ),
                                                              );
                                                      },
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedPickUp = 'pick';
                                                      });
                                                      info == null
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const MapScreen(
                                                                      isPick:
                                                                          true,
                                                                    ),
                                                              ),
                                                            )
                                                          : setState(() {
                                                              _selectedPickUp =
                                                                  'pick';
                                                              _toggleExpand(true);
                                                            });
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MapScreen(
                                                              isPick: true,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubHeading(
                          title: 'Return Location:',
                          icon: null,
                          onTap: () {},
                        ),
                        !isExpandedReturn
                            ? TextButton(
                                onPressed: () => _toggleExpand(false),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Collapsed view
                          if (_showCollapsedReturn)
                            AnimatedOpacity(
                              opacity: isExpandedReturn ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 500),
                              child: ListTile(
                                title: Text(
                                  _selectedReturn == 'office'
                                      ? 'Rent App HQ'
                                      : _selectedReturn == 'current'
                                      ? 'Current Location'
                                      : _selectedReturn == 'pick'
                                      ? 'Pick Location'
                                      : 'Unknown',
                                ),
                                leading: Radio<String>(
                                  value: _selectedReturn,
                                  groupValue: _selectedReturn,
                                  onChanged: null,
                                ),
                                subtitle: _selectedReturn == 'office' ? Text("Pekanbaru"):
                                Consumer<MapProvider>(
                                  builder: (context, provider, _) {
                                    final info = _selectedReturn == "pick" ? provider.placemarkReturn : _selectedReturn == "current" ? provider.placemarkCurrent : null;
                                    return info != null
                                        ? Text(
                                      maxLines: 5,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                    )
                                        : Container();
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedReturn;
                                    _toggleExpand(false);
                                  });
                                },
                              ),
                            ),

                          // Expanded view
                          if (_showExpandedReturn)
                            AnimatedOpacity(
                              opacity: isExpandedReturn ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text('Rent App HQ'),
                                    subtitle: Text("Pekanbaru"),
                                    leading: Radio<String>(
                                      value: 'office',
                                      groupValue: _selectedReturn,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedReturn = value!;
                                        });
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedReturn = 'office';
                                        _toggleExpand(false);
                                      });
                                    },
                                  ),
                                  Consumer<MapProvider>(
                                    builder: (context, provider, _) {
                                      final info = provider.placemarkCurrent;
                                      return ListTile(
                                        title: Text('Current Location'),
                                        subtitle: info != null
                                            ? Text(
                                          "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                            : const Text("No location selected."),
                                        leading: Radio<String>(
                                          value: 'current',
                                          groupValue: _selectedReturn,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedReturn = value!;
                                            });
                                            if (info == null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const MapScreen(isPick: true),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedReturn = 'current';
                                          });
                                          if (info == null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const MapScreen(isPick: true),
                                              ),
                                            );
                                          } else {
                                            _toggleExpand(false);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  Consumer<MapProvider>(
                                    builder: (context, provider, _) {
                                      final info = provider.placemarkReturn;
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: const Text(
                                                'Pick Location',
                                              ),
                                              subtitle: info != null
                                                  ? Text(
                                                "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                                maxLines: 5,
                                                overflow: TextOverflow
                                                    .ellipsis,
                                              )
                                                  : const Text(
                                                "No location selected.",
                                              ),
                                              leading: Radio<String>(
                                                value: 'pick',
                                                groupValue: _selectedReturn,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedReturn =
                                                    value!;
                                                  });
                                                  info != null
                                                      ? null
                                                      : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MapScreen(
                                                        isPick:
                                                        false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _selectedReturn = 'pick';
                                                });
                                                info == null
                                                    ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const MapScreen(
                                                      isPick:
                                                      false,
                                                    ),
                                                  ),
                                                )
                                                    : setState(() {
                                                  _selectedReturn =
                                                  'pick';
                                                  _toggleExpand(false);
                                                });
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                  const MapScreen(
                                                    isPick: false,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}
