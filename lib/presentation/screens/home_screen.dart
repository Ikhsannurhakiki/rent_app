import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/screens/detail_page.dart';
import 'package:rent_app/presentation/widgets/on_going_card.dart';
import 'package:rent_app/presentation/widgets/subHeading.dart';

import '../../common/state_enum.dart';
import '../../data/dummyItems.dart';
import '../provider/unit_notifier.dart';
import '../style/colors/app_colors.dart';
import '../widgets/rent_banner.dart';
import '../widgets/rent_item_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UnitNotifier>(context, listen: false)
        ..fetchRecommendations();
          // ..fetchUnitTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/appbar/appbar1.png",
              width: 100,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
            FittedBox(
              child: Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Pekanbaru, Riau",
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, size: 25),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RentBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: SubHeading(title: 'On Going . . . . .',icon:  Icons.navigate_next_rounded, onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OnGoingCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: SubHeading(title: 'Top Rented Near You',icon:  Icons.navigate_next_rounded, onTap: () {}),
            ),
            Consumer<UnitNotifier>(
              builder: (context, data, child) {
                print(data.recommendationUnitsState);
                if (data.recommendationUnitsState == RequestState.Loading) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (data.recommendationUnitsState ==
                    RequestState.Loaded) {
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.recommendationsUnit.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final item = data.recommendationsUnit[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: RentCard(
                            item: item,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UnitDetailPage(
                                    id: item.id,
                                    typeId: item.unitTypeId,
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
                      child: Center(child: Text("Error loading data")),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: SubHeading(title: 'Closest Recommendations',icon:  Icons.navigate_next_rounded, onTap: () {}),
            ),
            Consumer<UnitNotifier>(
              builder: (context, data, child) {
                print(data.recommendationUnitsState);
                if (data.recommendationUnitsState == RequestState.Loading) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (data.recommendationUnitsState ==
                    RequestState.Loaded) {
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.recommendationsUnit.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final item = data.recommendationsUnit[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: RentCard(
                            item: item,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UnitDetailPage(
                                    id: item.id,
                                    typeId: item.unitTypeId,
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
                      child: Center(child: Text("Error loading data")),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: SubHeading(title: 'Electric Vehicles',icon:  Icons.navigate_next_rounded, onTap: () {}),
            ),
            Consumer<UnitNotifier>(
              builder: (context, data, child) {
                print(data.recommendationUnitsState);
                if (data.recommendationUnitsState == RequestState.Loading) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (data.recommendationUnitsState ==
                    RequestState.Loaded) {
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.recommendationsUnit.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final item = data.recommendationsUnit[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: RentCard(
                            item: item,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UnitDetailPage(
                                    id: item.id,
                                    typeId: item.unitTypeId,
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
                      child: Center(child: Text("Error loading data")),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
