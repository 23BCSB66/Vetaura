import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CareMapScreen extends StatefulWidget {
  const CareMapScreen({super.key});

  @override
  State<CareMapScreen> createState() => _CareMapScreenState();
}

class _CareMapScreenState extends State<CareMapScreen> {

  late GoogleMapController mapController;

  final LatLng initialLocation = const LatLng(
    20.2961, // Bhubaneswar
    85.8245,
  );

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('rescue1'),
      position: LatLng(20.3000, 85.8200),
      infoWindow: InfoWindow(title: 'Rescue Center'),
    ),
    const Marker(
      markerId: MarkerId('vet1'),
      position: LatLng(20.2900, 85.8300),
      infoWindow: InfoWindow(title: 'Nearby Vet'),
    ),
  };

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          /// HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Expanded(
                    child: Text(
                      "Care Map\nFind Help Nearby",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.my_location_rounded,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// MAP
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: screenHeight * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialLocation,
                    zoom: 13,
                  ),
                  markers: markers,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                ),
              ),
            ),
          ),

          /// INFO CARDS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
              child: Column(
                children: [

                  _buildInfoCard(
                    icon: Icons.local_hospital,
                    title: "Veterinary Clinics",
                    subtitle: "Find nearby vets for injured animals",
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 14),

                  _buildInfoCard(
                    icon: Icons.pets,
                    title: "Rescue Centers",
                    subtitle: "Animal rescue organisations near you",
                    color: Colors.orange,
                  ),

                  const SizedBox(height: 14),

                  _buildInfoCard(
                    icon: Icons.home,
                    title: "Shelters",
                    subtitle: "Places offering shelter for strays",
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}