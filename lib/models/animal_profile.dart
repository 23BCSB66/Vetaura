class AnimalProfile {
  final String id;
  final String name;
  final String type;
  final String breed;
  final String age;
  final int ageInMonths;
  final String gender;
  final String description;
  final String imageUrl;
  final List<String> personalityTags;
  final String shelterName;
  final bool vaccinated;
  final List<String> vaccinationHistory;
  final String nature;
  final String specialCare;
  final String medicalConditions;

  AnimalProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.ageInMonths,
    required this.gender,
    required this.description,
    required this.imageUrl,
    required this.personalityTags,
    required this.shelterName,
    required this.vaccinated,
    required this.vaccinationHistory,
    required this.nature,
    required this.specialCare,
    required this.medicalConditions,
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
      ageInMonths: 24,
      gender: 'Male',
      description:
          'Max was rescued from an abandoned property. He is incredibly sweet, loves to play fetch, and gets along wonderfully with kids and other dogs.',
      imageUrl:
          'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=600&h=600&fit=crop',
      personalityTags: ['Playful', 'Good with Kids', 'High Energy'],
      shelterName: 'Paws & Care Shelter',
      vaccinated: true,
      vaccinationHistory: ['Anti-rabies', 'DHPP booster', 'Kennel cough'],
      nature: 'Playful and friendly',
      specialCare: 'Needs daily exercise and interactive play time.',
      medicalConditions: 'No active medical conditions reported.',
    ),
    AnimalProfile(
      id: '2',
      name: 'Luna',
      type: 'Cat',
      breed: 'Persian',
      age: '1 Year',
      ageInMonths: 12,
      gender: 'Female',
      description:
          'Luna is a quiet and affectionate cat. She loves curling up in sunny spots and being brushed.',
      imageUrl:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600&h=600&fit=crop',
      personalityTags: ['Quiet', 'Affectionate', 'Indoor Only'],
      shelterName: 'Happy Tails Rescue',
      vaccinated: true,
      vaccinationHistory: ['FVRCP', 'Anti-rabies'],
      nature: 'Calm and affectionate',
      specialCare: 'Prefers a quieter indoor environment.',
      medicalConditions: 'Mild tear-stain sensitivity; regular grooming helps.',
    ),
    AnimalProfile(
      id: '3',
      name: 'Rocky',
      type: 'Dog',
      breed: 'German Shepherd',
      age: '3 Years',
      ageInMonths: 36,
      gender: 'Male',
      description:
          'Rocky is a smart, loyal companion. He knows basic commands and would excel with an active family who loves the outdoors.',
      imageUrl:
          'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&h=600&fit=crop',
      personalityTags: ['Loyal', 'Smart', 'Active'],
      shelterName: 'Second Chance Canines',
      vaccinated: true,
      vaccinationHistory: ['Anti-rabies', 'DHPP booster'],
      nature: 'Alert and protective',
      specialCare: 'Benefits from consistent training and structure.',
      medicalConditions: 'Old leg injury healed; avoid excessive jumping.',
    ),
    AnimalProfile(
      id: '4',
      name: 'Bella',
      type: 'Cat',
      breed: 'Tabby',
      age: '6 Months',
      ageInMonths: 6,
      gender: 'Female',
      description:
          "Bella is a curious little kitten who loves exploring and playing with feather toys. She's ready to find her forever home.",
      imageUrl: 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
      personalityTags: ['Curious', 'Playful', 'Kitten'],
      shelterName: 'Paws & Care Shelter',
      vaccinated: false,
      vaccinationHistory: ['First deworming complete'],
      nature: 'Curious and energetic',
      specialCare: 'Needs kitten-safe toys and regular starter vaccinations.',
      medicalConditions: 'None observed.',
    ),
    AnimalProfile(
      id: '5',
      name: 'Charlie',
      type: 'Dog',
      breed: 'Beagle',
      age: '4 Years',
      ageInMonths: 48,
      gender: 'Male',
      description:
          'Charlie is a very loving Beagle. He is food motivated and loves going on long sniffaris around the neighborhood.',
      imageUrl:
          'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?w=600&h=600&fit=crop',
      personalityTags: ['Loving', 'Foodie', 'Vocal'],
      shelterName: 'Happy Tails Rescue',
      vaccinated: true,
      vaccinationHistory: ['Anti-rabies', 'DHPP booster', 'Deworming'],
      nature: 'Loving but vocal',
      specialCare: 'Watch diet portions and provide scent-based play.',
      medicalConditions: 'Needs seasonal allergy monitoring.',
    ),
    AnimalProfile(
      id: '6',
      name: 'Mochi',
      type: 'Cat',
      breed: 'Scottish Fold Mix',
      age: '2 Months',
      ageInMonths: 2,
      gender: 'Female',
      description:
          'Mochi is a tiny rescue kitten with a huge purr. She loves warm blankets, soft toys, and being carried around like royalty.',
      imageUrl:
          'https://images.unsplash.com/photo-1519052537078-e6302a4968d4?w=600&h=600&fit=crop',
      personalityTags: ['Tiny', 'Snuggly', 'Gentle'],
      shelterName: 'Whisker Wish Home',
      vaccinated: false,
      vaccinationHistory: ['Dewormed once'],
      nature: 'Soft, cuddly, and slightly shy at first',
      specialCare: 'Needs kitten formula support for another week and gradual socialization.',
      medicalConditions: 'Underweight but steadily improving.',
    ),
    AnimalProfile(
      id: '7',
      name: 'Rusty',
      type: 'Dog',
      breed: 'Indie Street Dog',
      age: '5 Years',
      ageInMonths: 60,
      gender: 'Male',
      description:
          'Rusty is a resilient indie who lost one front leg after an old accident. He moves around confidently and still gets excited for walks and cuddles.',
      imageUrl:
          'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=600&h=600&fit=crop',
      personalityTags: ['Resilient', 'Affectionate', 'Calm'],
      shelterName: 'Second Chance Canines',
      vaccinated: true,
      vaccinationHistory: ['Anti-rabies', 'DHPP booster', 'Tick treatment'],
      nature: 'Calm and trusting once comfortable',
      specialCare: 'Needs non-slip flooring and shorter, gentler walks.',
      medicalConditions: 'Three-legged mobility; otherwise healthy.',
    ),
    AnimalProfile(
      id: '8',
      name: 'Kiwi',
      type: 'Bird',
      breed: 'Budgerigar',
      age: '8 Months',
      ageInMonths: 8,
      gender: 'Female',
      description:
          'Kiwi is a bright green budgie who chirps cheerfully through the morning and enjoys millet treats and mirror toys.',
      imageUrl:
          'https://images.unsplash.com/photo-1444464666168-49d633b86797?w=600&h=600&fit=crop',
      personalityTags: ['Curious', 'Chirpy', 'Social'],
      shelterName: 'Sky Wings Rescue',
      vaccinated: false,
      vaccinationHistory: ['Routine wellness check completed'],
      nature: 'Alert and social',
      specialCare: 'Needs daily out-of-cage enrichment and a quiet sleeping corner.',
      medicalConditions: 'No active concerns.',
    ),
    AnimalProfile(
      id: '9',
      name: 'Hazel',
      type: 'Guinea Pig',
      breed: 'Abyssinian Guinea Pig',
      age: '1 Year',
      ageInMonths: 12,
      gender: 'Female',
      description:
          'Hazel is a gentle guinea pig with a fluffy coat and a soft whistle whenever fresh veggies appear.',
      imageUrl:
          'https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=600&h=600&fit=crop',
      personalityTags: ['Gentle', 'Food Motivated', 'Bonded-Friendly'],
      shelterName: 'Little Paws Haven',
      vaccinated: false,
      vaccinationHistory: ['Parasite screening done'],
      nature: 'Gentle and observant',
      specialCare: 'Needs vitamin C rich veggies and a spacious enclosure.',
      medicalConditions: 'Sensitive skin; paper bedding recommended.',
    ),
    AnimalProfile(
      id: '10',
      name: 'Pebble',
      type: 'Hamster',
      breed: 'Syrian Hamster',
      age: '4 Months',
      ageInMonths: 4,
      gender: 'Male',
      description:
          'Pebble is a night owl hamster who loves tunnels, seed mixes, and carefully stacking bedding into the fluffiest nest possible.',
      imageUrl:
          'https://images.unsplash.com/photo-1425082661705-1834bfd09dca?w=600&h=600&fit=crop',
      personalityTags: ['Nocturnal', 'Busy', 'Independent'],
      shelterName: 'Tiny Tails Corner',
      vaccinated: false,
      vaccinationHistory: ['Initial health screening done'],
      nature: 'Independent but curious',
      specialCare: 'Prefers quiet handling and lots of burrowing space.',
      medicalConditions: 'One healed tail nick; no treatment currently needed.',
    ),
    AnimalProfile(
      id: '11',
      name: 'Snow',
      type: 'Rabbit',
      breed: 'Lionhead Mix',
      age: '9 Months',
      ageInMonths: 9,
      gender: 'Female',
      description:
          'Snow is a fluffy white rabbit who enjoys leafy greens, hidey houses, and gentle head pets once she feels safe.',
      imageUrl:
          'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=600&h=600&fit=crop',
      personalityTags: ['Quiet', 'Gentle', 'Indoor Pet'],
      shelterName: 'Meadow Hop Rescue',
      vaccinated: true,
      vaccinationHistory: ['Myxomatosis', 'Rabbit hemorrhagic disease'],
      nature: 'Quiet and sensitive',
      specialCare: 'Needs daily hay, chew toys, and supervised roaming time.',
      medicalConditions: 'Requires regular brushing around the mane.',
    ),
    AnimalProfile(
      id: '12',
      name: 'Paco',
      type: 'Bird',
      breed: 'Cockatiel',
      age: '2 Years',
      ageInMonths: 24,
      gender: 'Male',
      description:
          'Paco whistles back when spoken to and has started learning a few tiny tunes from the volunteers.',
      imageUrl:
          'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?w=600&h=600&fit=crop',
      personalityTags: ['Vocal', 'Smart', 'Companion Bird'],
      shelterName: 'Sky Wings Rescue',
      vaccinated: false,
      vaccinationHistory: ['Beak and wing trim record available'],
      nature: 'Interactive and expressive',
      specialCare: 'Needs social time daily and perches of varying textures.',
      medicalConditions: 'Mild feather-plucking history during stress.',
    ),
    AnimalProfile(
      id: '13',
      name: 'Maple',
      type: 'Dog',
      breed: 'Cocker Spaniel',
      age: '7 Months',
      ageInMonths: 7,
      gender: 'Female',
      description:
          'Maple is a silky-eared youngster who adores children, gentle training games, and squeaky toys.',
      imageUrl:
          'https://images.unsplash.com/photo-1517849845537-4d257902454a?w=600&h=600&fit=crop',
      personalityTags: ['Sweet', 'Trainable', 'Family Friendly'],
      shelterName: 'Paws & Care Shelter',
      vaccinated: true,
      vaccinationHistory: ['Anti-rabies', 'DHPP puppy series'],
      nature: 'Sweet and eager to please',
      specialCare: 'Needs regular brushing and ear cleaning.',
      medicalConditions: 'Mild ear sensitivity; weekly checks advised.',
    ),
    AnimalProfile(
      id: '14',
      name: 'Shadow',
      type: 'Cat',
      breed: 'Bombay Mix',
      age: '4 Years',
      ageInMonths: 48,
      gender: 'Male',
      description:
          'Shadow is a sleek black cat with one cloudy eye from an old infection. He is mellow, observant, and deeply loyal to his chosen human.',
      imageUrl:
          'https://images.unsplash.com/photo-1533743983669-94fa5c4338ec?w=600&h=600&fit=crop',
      personalityTags: ['Mellow', 'Observant', 'Loyal'],
      shelterName: 'Whisker Wish Home',
      vaccinated: true,
      vaccinationHistory: ['FVRCP', 'Anti-rabies', 'Deworming'],
      nature: 'Mellow and quiet',
      specialCare: 'Needs a calm home and occasional eye cleaning.',
      medicalConditions: 'Partial vision loss in left eye.',
    ),
    AnimalProfile(
      id: '15',
      name: 'Pip',
      type: 'Guinea Pig',
      breed: 'American Guinea Pig',
      age: '3 Months',
      ageInMonths: 3,
      gender: 'Male',
      description:
          'Pip is a tiny chatterbox who popcorn-jumps when he hears veggie bags rustle and loves soft fleece bedding.',
      imageUrl:
          'https://images.unsplash.com/photo-1591561582301-7ce6588cc286?w=600&h=600&fit=crop',
      personalityTags: ['Young', 'Chatty', 'Playful'],
      shelterName: 'Little Paws Haven',
      vaccinated: false,
      vaccinationHistory: ['Starter wellness check complete'],
      nature: 'Playful and squeaky',
      specialCare: 'Best adopted with another guinea pig companion.',
      medicalConditions: 'No active conditions.',
    ),
  ];
}
