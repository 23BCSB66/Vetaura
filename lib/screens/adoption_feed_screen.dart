import 'package:flutter/material.dart';
import '../models/animal_profile.dart';
import 'animal_detail_screen.dart';

class AdoptionFeedScreen extends StatelessWidget {
  const AdoptionFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final animals = MockAnimalDatabase.animals;
    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount =
    screenWidth > 900 ? 4 : screenWidth > 600 ? 3 : 2;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          /// HEADER (scrolls with page)
          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Expanded(
                    child: Text(
                      'Forever Homes\nFind Your Best Friend',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: Colors.pink.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// GRID
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            sliver: SliverGrid(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),

              delegate: SliverChildBuilderDelegate(
                    (context, index) {

                  final animal = animals[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AnimalDetailScreen(animal: animal),
                        ),
                      );
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// IMAGE
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.network(
                                  animal.imageUrl,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;

                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.pets,
                                        size: 50,
                                        color: Colors.grey.shade400,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          /// INFO
                          Padding(
                            padding: const EdgeInsets.all(12),

                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [

                                    Expanded(
                                      child: Text(
                                        animal.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Color(0xFF2D3748),
                                        ),
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                    ),

                                    const SizedBox(width: 6),

                                    Icon(
                                      animal.gender == 'Male'
                                          ? Icons.male_rounded
                                          : Icons.female_rounded,
                                      size: 16,
                                      color:
                                      animal.gender == 'Male'
                                          ? Colors.blue
                                          .shade400
                                          : Colors.pink
                                          .shade400,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  animal.breed,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade50,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    animal.age,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight:
                                      FontWeight.w600,
                                      color:
                                      Colors.pink.shade600,
                                    ),
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
                childCount: animals.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}