class AnimalProfile {
  final String id;
  final String name;
  final String type; // Dog, Cat, etc.
  final String breed;
  final String age;
  final String gender;
  final String description;
  final String imageUrl;
  final List<String> personalityTags;
  final String shelterName;

  AnimalProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.description,
    required this.imageUrl,
    required this.personalityTags,
    required this.shelterName,
  });
}

class MockAnimalDatabase {
  static final List<AnimalProfile> animals = [
    AnimalProfile(
      id: '1',
      name: 'Max',
      type: 'Dog',
      breed: 'Golden Retriever Mix',
      age: '2 Years',
      gender: 'Male',
      description: 'Max was rescued from an abandoned property. He is incredibly sweet, loves to play fetch, and gets along wonderfully with kids and other dogs.',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=600&h=600&fit=crop',
      personalityTags: ['Playful', 'Good with Kids', 'High Energy'],
      shelterName: 'Paws & Care Shelter',
    ),
    AnimalProfile(
      id: '2',
      name: 'Luna',
      type: 'Cat',
      breed: 'Persian',
      age: '1 Year',
      gender: 'Female',
      description: 'Luna is a quiet and affectionate cat. She loves curling up in sunny spots and being brushed.',
      imageUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600&h=600&fit=crop',
      personalityTags: ['Quiet', 'Affectionate', 'Indoor Only'],
      shelterName: 'Happy Tails Rescue',
    ),
    AnimalProfile(
      id: '3',
      name: 'Rocky',
      type: 'Dog',
      breed: 'German Shepherd',
      age: '3 Years',
      gender: 'Male',
      description: 'Rocky is a smart, loyal companion. He knows basic commands and would excel with an active family who loves the outdoors.',
      imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&h=600&fit=crop',
      personalityTags: ['Loyal', 'Smart', 'Active'],
      shelterName: 'Second Chance Canines',
    ),
    AnimalProfile(
      id: '4',
      name: 'Bella',
      type: 'Cat',
      breed: 'Tabby',
      age: '6 Months',
      gender: 'Female',
      description: 'Bella is a curious little kitten who loves exploring and playing with feather toys. She\'s ready to find her forever home.',
      imageUrl: 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
      personalityTags: ['Curious', 'Playful', 'Kitten'],
      shelterName: 'Paws & Care Shelter',
    ),
    AnimalProfile(
      id: '5',
      name: 'Charlie',
      type: 'Dog',
      breed: 'Beagle',
      age: '4 Years',
      gender: 'Male',
      description: 'Charlie is a very loving Beagle. He is food motivated and loves going on long sniffaris around the neighborhood.',
      imageUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?w=600&h=600&fit=crop',
      personalityTags: ['Loving', 'Foodie', 'Vocal'],
      shelterName: 'Happy Tails Rescue',
    ),
  ];
}
