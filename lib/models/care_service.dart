class CareService {
  final String id;
  final String name;
  final String type; // NGO, Shelter, Vet
  final String address;
  final String distance;
  final bool isOpen24x7;
  final double rating;

  CareService({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.distance,
    required this.isOpen24x7,
    required this.rating,
  });
}

class MockCareDatabase {
  static final List<CareService> services = [
    CareService(
      id: '1',
      name: 'Paws & Care NGO',
      type: 'NGO',
      address: '123 Rescue Avenue, City Center',
      distance: '2.3 km',
      isOpen24x7: true,
      rating: 4.8,
    ),
    CareService(
      id: '2',
      name: 'Happy Tails Shelter',
      type: 'Shelter',
      address: '45 Safe Haven Road, North District',
      distance: '5.1 km',
      isOpen24x7: false,
      rating: 4.5,
    ),
    CareService(
      id: '3',
      name: 'City Vet Clinic 24/7',
      type: 'Vet',
      address: '78 Medical Blvd, East Side',
      distance: '3.8 km',
      isOpen24x7: true,
      rating: 4.9,
    ),
    CareService(
      id: '4',
      name: 'Second Chance Canines',
      type: 'Shelter',
      address: '99 Hope Street, West End',
      distance: '8.4 km',
      isOpen24x7: false,
      rating: 4.6,
    ),
    CareService(
      id: '5',
      name: 'Dr. Smith Animal Hospital',
      type: 'Vet',
      address: '210 Healing Way, South Park',
      distance: '1.2 km',
      isOpen24x7: false,
      rating: 4.7,
    ),
  ];
}
