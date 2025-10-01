import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/data/entities/owner_detail_entity.dart';
import 'package:rent_app/presentation/provider/owner_notifier.dart';

import '../../common/state_enum.dart';
import '../provider/auth_provider.dart';

class OwnerDetailScreen extends StatefulWidget {
  final int ownerId;

  const OwnerDetailScreen({
    super.key,
    required this.ownerId
  });

  @override
  State<OwnerDetailScreen> createState() => _RentalDetailScreenState();
}

class _RentalDetailScreenState extends State<OwnerDetailScreen> {

  @override
  void initState() {
    Future.microtask(() {
      final authProvider = context.read<AuthProvider>();
      Provider.of<OwnerNotifier>(
        context,
        listen: false,
      ).fetchOwnerDetail(ownerId: widget.ownerId,
          apiKey: authProvider.currentUserEntity!.apiKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OwnerNotifier>(
        builder: (context, provider, child) {
          if (provider.detailState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.detailState == RequestState.Loaded) {
            final ownerDetail = provider.detailOwner;
            return SafeArea(child: OwnerDetailContent(ownerDetail));
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class OwnerDetailContent extends StatefulWidget {
  final OwnerDetailEntity ownerDetailEntity;

  OwnerDetailContent(this.ownerDetailEntity);

  @override
  State<OwnerDetailContent> createState() => _OwnerDetailContentState();
}

class _OwnerDetailContentState extends State<OwnerDetailContent> {
  @override
  Widget build(BuildContext context) {
    final owner = widget.ownerDetailEntity;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: owner.businessProfilePictureUrl.isNotEmpty
                            ? Image.network(
                          owner.businessProfilePictureUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) =>
                               Container(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                child: Center(
                                  child: Text(
                                   owner.businessName.isNotEmpty
                                        ? owner.businessName
                                        .trim()
                                        .split(' ')
                                        .where((s) => s.isNotEmpty)
                                        .map((s) => s[0])
                                        .take(2)
                                        .join()
                                        : '',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress
                                          .expectedTotalBytes ??
                                          1)
                                      : null,
                                ),
                              ),
                            );
                          },
                        )
                            : Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Center(
                            child: Text(
                              owner.businessName.isNotEmpty
                                  ? owner.businessName
                                  .trim()
                                  .split(' ')
                                  .where((s) => s.isNotEmpty)
                                  .map((s) => s[0])
                                  .take(2)
                                  .join()
                                  : '',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              owner.businessName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "By ${owner.ownerName}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              owner.phoneNumber,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        ]
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            const Divider(),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "price",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "description",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "address",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.phone_outlined),
                  const SizedBox(width: 8),
                  Text(
                    owner.phoneNumber,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement booking or contact action
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text("Book Now"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
