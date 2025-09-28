import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/presentation/widgets/subHeading.dart';

import '../provider/map_provider.dart';
import '../screens/map_screens.dart';

class LocationPicker extends StatefulWidget {
  final bool isPickup;

  const LocationPicker({super.key, required this.isPickup});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String _selected = 'office';
  bool isExpandedPickUp = false;
  bool _showCollapsedPickUp = true;
  bool _showExpandedPickUp = false;
  bool isExpandedReturn = false;
  bool _showCollapsedReturn = true;
  bool _showExpandedReturn = false;

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
    return Consumer<UnitNotifier>(
      builder: (context, provider, child) {
        child:
        return Card(
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
                      title: widget.isPickup
                          ? 'Pickup Location:'
                          : 'Return Location:',
                      icon: null,
                      onTap: () {},
                    ),
                    !isExpandedReturn
                        ? TextButton(
                            onPressed: () => _toggleExpand(false),
                            child: Text(
                              'Change',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
                      if (_showCollapsedReturn)
                        AnimatedOpacity(
                          opacity: isExpandedReturn ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: ListTile(
                            title: Text(
                              _selected == 'office'
                                  ? provider
                                        .detailUnit
                                        .ownerDetails!
                                        .businessName
                                  : _selected == 'current'
                                  ? 'Current Location'
                                  : _selected == 'pick'
                                  ? 'Pick Location'
                                  : 'Unknown',
                            ),
                            leading: Radio<String>(
                              value: _selected,
                              groupValue: _selected,
                              onChanged: null,
                            ),
                            subtitle: Consumer<MapProvider>(
                              builder: (context, provider, _) {
                                final info = _selected == 'office'
                                    ? provider.placemarkOffice
                                    : _selected == "pick"
                                    ? provider.placemarkReturn
                                    : _selected == "current"
                                    ? provider.placemarkCurrent
                                    : null;
                                return info != null
                                    ? Text(
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                      )
                                    : Container();
                              },
                            ),
                            onTap: () {
                              setState(() {
                                _selected;
                                _toggleExpand(false);
                              });
                            },
                          ),
                        ),

                      if (_showExpandedReturn)
                        AnimatedOpacity(
                          opacity: isExpandedReturn ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  provider
                                      .detailUnit
                                      .ownerDetails!
                                      .businessName,
                                ),
                                subtitle: Consumer<MapProvider>(
                                  builder: (context, provider, _) {
                                    final info = provider.placemarkOffice;
                                    return info != null
                                        ? Text(
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            "${info.street!}, ${info.subLocality!}, ${info.locality!}, ${info.postalCode!}, ${info.subAdministrativeArea!}, ${info.administrativeArea!}, ${info.country}",
                                          )
                                        : Container();
                                  },
                                ),
                                leading: Radio<String>(
                                  value: 'office',
                                  groupValue: _selected,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value!;
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    _selected = 'office';
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
                                            style: TextStyle(fontSize: 12),
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : const Text("No location selected."),
                                    leading: Radio<String>(
                                      value: 'current',
                                      groupValue: _selected,
                                      onChanged: (value) {
                                        setState(() {
                                          _selected = value!;
                                        });
                                        if (info == null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MapScreen(isPick: true),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selected = 'current';
                                      });
                                      if (info == null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MapScreen(isPick: true),
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
                                  bool isPickUp = widget.isPickup;
                                  final info = widget.isPickup?provider.placemarkPickUp: provider.placemarkReturn;
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Pick Location'),
                                          subtitle: info != null
                                              ? Consumer<MapProvider>(
                                            builder: (context, provider, _) {
                                              final distance = widget.isPickup
                                                  ? provider.distanceCurrent
                                                  : provider.distanceReturn;
                                              return Text(
                                                "${info.street!}, ${info.locality!} (${(distance/1000).toStringAsFixed(2)} km)",
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              );
                                            },
                                          )
                                              : const Text("No location selected."),
                                          leading: Radio<String>(
                                            value: 'pick',
                                            groupValue: _selected,
                                            onChanged: (value) {
                                              setState(() {
                                                _selected = value!;
                                              });
                                              info != null
                                                  ? null
                                                  : Navigator.push(
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
                                          onTap: () {
                                            setState(() {
                                              _selected = 'pick';
                                            });
                                            info == null
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MapScreen(
                                                            isPick: isPickUp,
                                                          ),
                                                    ),
                                                  )
                                                : setState(() {
                                                    _selected = 'pick';
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
                                                  MapScreen(
                                                    isPick: isPickUp,
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
        );
      },
    );
  }
}
